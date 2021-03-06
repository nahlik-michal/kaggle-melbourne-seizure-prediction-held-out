function train_and_save_dt(data,opts)
%TRAIN_AND_RUN_DT Train classification decission tree on train data and get output for the test data part

    xTrain = squeeze(data.xTrain(:,opts.channel_index,:));
    yTrain = data.yTrain;

    if isfield(opts, 'min_leaf')
        min_leaf = opts.min_leaf;
    else
        min_leaf = 1;
    end
    
    if isfield(opts, 'min_parent')
        min_parent = opts.min_parent;
    else
        min_parent = 10;
    end
    
    if isfield(opts, 'max_cat')
        max_cat = opts.max_cat;
    else
        max_cat = 10;
    end
    
    if isfield(opts, 'algorithm')
        alg = opts.algorithm;
    else
        alg = 'Exact';
    end
    
    dt_model = fitctree(real(xTrain),yTrain, 'MinLeaf',min_leaf,'MinParent', min_parent, 'MaxCat', max_cat, 'AlgorithmForCategorical', alg, 'CrossVal','on', 'PredictorNames', opts.varNames);
    %% 
    if (~isdir(opts.modelDir))
        mkdir(opts.modelDir);
    end
        
    model_name = sprintf('DT_%d_%d',opts.subject_index, opts.channel_index);
    save([opts.modelDir filesep model_name], 'dt_model');
end

