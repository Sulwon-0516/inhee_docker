#
# Copyright (C) 2022 Apple Inc. All rights reserved.
#

'''
Preprocess
'''

import argparse
import os


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--video', default=False, type=bool, help='is video input or colmap input')
    parser.add_argument('--path', required=True, type=str, help='the path to the source video')
    parser.add_argument('--mask_path', default=True, type=str, help='the path to the source video')
    parser.add_argument('--name', default='debug', type=str, help='the path to the source video')

    opt = parser.parse_args()

    if not opt.video:
        #just do monocular depth estimation
        assert os.path.isdir(opt.path)
        video_name = opt.name
        video_dir = opt.path

    else:
        assert os.path.isfile(opt.path)
        video_name = os.path.splitext(os.path.basename(opt.video))[0]
        video_dir = os.path.dirname(os.path.abspath(opt.video))

    steps = 10
    
    code_dir = os.path.dirname(os.path.realpath(__file__))
    
    print(code_dir)

    commands = []
    commands.append('#!/bin/bash')

    if opt.video:
        # Extract video frames
        commands.append(f'echo ========================================')
        commands.append(f'echo 1/{steps}: Extract frames')
        commands.append(f'echo ========================================')
        if not os.path.isdir(os.path.join(video_dir, f'{video_name}/raw_720p')):
            commands.append('conda activate BMD')
            commands.append(f'python save_video_frames.py --video {opt.video} --save_to {os.path.join(video_dir, video_name, "raw_720p")}  --width 1280 --height 720 --every 10 --skip=0')
            commands.append('conda deactivate')

        # Generate masks
        commands.append(f'echo ========================================')
        commands.append(f'echo 2/{steps}: Masks')
        commands.append(f'echo ========================================')
        commands.append(f'cd {os.path.join(code_dir, "detectron2/demo")}')
        if not os.path.isfile(os.path.join(code_dir, 'detectron2/demo/model_final_2d9806.pkl')):
            commands.append('wget https://dl.fbaipublicfiles.com/detectron2/COCO-InstanceSegmentation/mask_rcnn_X_101_32x8d_FPN_3x/139653917/model_final_2d9806.pkl')
        if not os.path.isdir(os.path.join(video_dir, f'{video_name}/raw_masks')):
            commands.append('conda activate BMD')
            commands.append(f'python demo.py --config-file ../configs/COCO-InstanceSegmentation/mask_rcnn_X_101_32x8d_FPN_3x.yaml --input {os.path.join(video_dir, f"{video_name}/raw_720p/*.png")} --output {os.path.join(video_dir, f"{video_name}/raw_masks")}  --opts MODEL.WEIGHTS ./model_final_2d9806.pkl')
            commands.append('conda deactivate')
        commands.append(f'cd {code_dir}')

        # Colmap
        commands.append(f'echo ========================================')
        commands.append(f'echo 3/{steps}: Sparse scene reconstrution')
        commands.append(f'echo ========================================')
        commands.append(f'cd {os.path.join(video_dir, video_name)}')
        if not os.path.isdir(os.path.join(video_dir, video_name, 'output/sparse')):
            commands.append('mkdir recon')
            commands.append('colmap feature_extractor --database_path ./recon/db.db --image_path ./raw_720p --ImageReader.mask_path ./raw_masks --SiftExtraction.estimate_affine_shape=true --SiftExtraction.domain_size_pool=true --ImageReader.camera_model SIMPLE_RADIAL --ImageReader.single_camera 1')
            commands.append('colmap exhaustive_matcher --database_path ./recon/db.db --SiftMatching.guided_matching=true')
            # commands.append('')
            commands.append('mkdir -p ./recon/sparse')
            commands.append('colmap mapper --database_path ./recon/db.db --image_path ./raw_720p --output_path ./recon/sparse')
            commands.append('if [ -d "./recon/sparse/1" ]; then echo "Bad reconstruction"; exit 1; else echo "Ok"; fi')
            commands.append('mkdir -p ./recon/dense')
            commands.append('colmap image_undistorter --image_path raw_720p --input_path ./recon/sparse/0/ --output_path ./recon/dense')
            commands.append('colmap patch_match_stereo --workspace_path ./recon/dense')
            commands.append('colmap model_converter --input_path ./recon/dense/sparse/ --output_path ./recon/dense/sparse --output_type=TXT')
            commands.append('mkdir ./output')
            commands.append('cp -r ./recon/dense/images ./output/images')
            commands.append('cp -r ./recon/dense/stereo/depth_maps ./output/depth_maps')
            commands.append('cp -r ./recon/dense/sparse ./output/sparse')
        commands.append(f'cd {code_dir}')

        # Generate masks for rectified images
        commands.append(f'echo ========================================')
        commands.append(f'echo 4/{steps}: Masks for rectified images')
        commands.append(f'echo ========================================')
        commands.append(f'cd {os.path.join(code_dir, "detectron2/demo")}')
        if not os.path.isdir(os.path.join(video_dir, f'{video_name}/output/segmentations')):
            commands.append('conda activate BMD')
            commands.append(f'python demo.py --config-file ../configs/COCO-InstanceSegmentation/mask_rcnn_X_101_32x8d_FPN_3x.yaml --input {os.path.join(video_dir, f"{video_name}/output/images/*.png")} --output {os.path.join(video_dir, f"{video_name}/output/segmentations")}  --opts MODEL.WEIGHTS ./model_final_2d9806.pkl')
            commands.append('conda deactivate')
        commands.append(f'cd {code_dir}')

        # Monocular depth estimation
        commands.append(f'echo ========================================')
        commands.append(f'echo 7/{steps}: Monocular depth')
        commands.append(f'echo ========================================')
        commands.append(f'cd {os.path.join(code_dir, "BoostingMonocularDepth")}')
        if not os.path.exists(os.path.join(code_dir, 'BoostingMonocularDepth/pix2pix/checkpoints/mergemodel')):
            os.makedirs(os.path.join(code_dir, 'BoostingMonocularDepth/pix2pix/checkpoints/mergemodel'))
        if not os.path.isfile(os.path.join(code_dir, 'BoostingMonocularDepth/pix2pix/checkpoints/mergemodel/latest_net_G.pth')):
            commands.append(f'wget https://sfu.ca/~yagiz/CVPR21/latest_net_G.pth -O {os.path.join(code_dir, "BoostingMonocularDepth/pix2pix/checkpoints/mergemodel/latest_net_G.pth")}')
        if not os.path.isfile(os.path.join(code_dir, 'BoostingMonocularDepth/res101.pth')):
            commands.append(f'wget https://cloudstor.aarnet.edu.au/plus/s/lTIJF4vrvHCAI31/download -O res101.pth')
        if not os.path.isdir(os.path.join(video_dir, f'{video_name}/output/mono_depth')):
            commands.append('conda activate BMD')
            commands.append(f'python run.py --Final --data_dir {os.path.join(video_dir, f"{video_name}/output/images")} --output_dir {os.path.join(video_dir, f"{video_name}/output/mono_depth")} --depthNet 2')
            commands.append('conda deactivate')
        commands.append(f'cd {code_dir}')

    else:
        commands.append('echo "we skip first 4 steps as its done already')

        # Monocular depth estimation
        commands.append(f'echo ========================================')
        commands.append(f'echo 7/{steps}: Monocular depth')
        commands.append(f'echo ========================================')
        commands.append(f'cd {os.path.join(code_dir, "BoostingMonocularDepth")}')
        if not os.path.exists(os.path.join(code_dir, 'BoostingMonocularDepth/pix2pix/checkpoints/mergemodel')):
            os.makedirs(os.path.join(code_dir, 'BoostingMonocularDepth/pix2pix/checkpoints/mergemodel'))
        if not os.path.isfile(os.path.join(code_dir, 'BoostingMonocularDepth/pix2pix/checkpoints/mergemodel/latest_net_G.pth')):
            commands.append(f'wget https://sfu.ca/~yagiz/CVPR21/latest_net_G.pth -O {os.path.join(code_dir, "BoostingMonocularDepth/pix2pix/checkpoints/mergemodel/latest_net_G.pth")}')
        if not os.path.isfile(os.path.join(code_dir, 'BoostingMonocularDepth/res101.pth')):
            commands.append(f'wget https://cloudstor.aarnet.edu.au/plus/s/lTIJF4vrvHCAI31/download -O res101.pth')
        if not os.path.isdir(os.path.join(video_dir, 'mono_depth')):
            commands.append('conda activate BMD')
            commands.append(f'python run.py --Final --data_dir {os.path.join(video_dir, "images")} --output_dir {os.path.join(video_dir, "mono_depth")} --depthNet 2')
            commands.append('conda deactivate')
        commands.append(f'cd {code_dir}')

    


if __name__ == "__main__":
    main()
