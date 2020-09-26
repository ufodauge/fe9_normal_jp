init {
    // make interval to prevent unexpected splitting
    vars.splitInterval = 0;
    vars.isSplittable = false;
    vars.split = false;
    vars.isPlayerPhase = true;
}

update {
    // state
    // if player phase
    // if (features["playerphase"].current > 85.0 &&
    //     features["playerphase"].old(1000) < 85.0) {
    if (features["PPhase"].current > 85.0 &&
        features["PPhase"].old(1000) < 85.0) {
        vars.isPlayerPhase = true;
    }

    vars.isSplittable = false;

    // if enemy phase
    // also including timing flag
    // if (features["enemyphase"].current > 85.0 &&
    //     features["enemyphase"].old(1000) < 85.0) {
    if (features["EPhase"].current > 85.0 &&
        features["menu"].current < 85.0 &&
        features["EPhase"].old(1000) < 85.0 &&
        features["menu"].old(1000) > 85.0) {
        vars.isPlayerPhase = false;
        vars.isSplittable = true;
        print("Splitted: EnemyPhase");
    }

    // timing flag
    // if save state (and player phase)
    if (features["save_black"].current > 90.0 &&
        features["save"].current < 95.0 &&
        features["save_black"].old(500) < 90.0 &&
        features["save"].old(500) > 95.0 &&
        vars.isPlayerPhase) {
        vars.isSplittable = true;
        print("Splitted: Save");
    }

    // if base out
    if (features["base01_black"].current > 90.0 &&
        features["base02_black"].current > 90.0 &&
        features["base01"].current < 95.0 &&
        features["base02"].current < 95.0 &&
        features["base01_black"].old(500) < 90.0 &&
        features["base02_black"].old(500) < 90.0 &&
        features["base01"].old(500) > 95.0 &&
        features["base02"].old(500) > 95.0) {
        vars.isSplittable = true;
        print("Splitted: Base Out");
    }

    // split flag
    if (vars.splitInterval > 0) {
        vars.splitInterval--;
        vars.split = false;
    }

    if (vars.splitInterval <= 0 && vars.isSplittable) {
        vars.splitInterval = 180;
        vars.split = true;
    }
}

start
{
    return features["save_black"].current > 90.0 &&
        features["load"].current < 95.0 &&
        features["save_black"].old(500) < 90.0 &&
        features["load"].old(500) > 95.0;
}

reset { }

split {
    return vars.split;
}

isLoading { }