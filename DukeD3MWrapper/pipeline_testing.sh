#!/bin/bash -e

Datasets=('196_autoMpg')
Datasets=('186_baseball' '26_radon_seed' '38_sick' '57_hypothyroid' 'LL0_186_braziltourism' 'LL0_207_autoPrice' 'SEMI_1217_click_prediction_small' 'uu4_SPECT' 'LL0_acled_reduced' 'LL1_multilearn_emotions')


cd "/duke_data/"

for i in "${Datasets[@]}"; do

    # generate and save pipeline    
    python3 "/duke_data/pipeline.py" $i

    # test and score pipeline
    start=`date +%s`
    python3 -m d3m runtime -d /datasets/ -v /duke_data/ fit-produce -p *.json -i /datasets/seed_datasets_current/$i/TRAIN/dataset_TRAIN/datasetDoc.json -t /datasets/seed_datasets_current/$i/TEST/dataset_TEST/datasetDoc.json -r /datasets/seed_datasets_current/$i/${i}_problem/problemDoc.json -O ${i}_pipeline_run.yaml
    end=`date +%s`
    runtime=$((end-start))

    # cleanup temporary file
    mv *.json pipeline_tests/${i}_pipeline.json
    mv ${i}_pipeline_run.yaml pipeline_tests/${i}_pipeline_run.yaml
    cp "/duke_data/pipeline.py" "/duke_data/pipeline_tests/${i}_pipeline.py"
    rm *.meta
done