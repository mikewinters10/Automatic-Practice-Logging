r_140507 = genConfMat('140507', r);
r_140514 = genConfMat('140514', r);
r_140515 = genConfMat('140515', r);
r_140522 = genConfMat('140522', r);
r_140505 = genConfMat('140505', r);
r_140511 = genConfMat('140511', r);
% r_140521 = genConfMat('140521', r)
% r_140522 = genConfMat('140522', r)

confMatBig = r_140505.confusionMat+r_140507.confusionMat+r_140511.confusionMat ...
    + r_140514.confusionMat + r_140515.confusionMat + ...
    + r_140521.confusionMat + r_140522.confusionMat;