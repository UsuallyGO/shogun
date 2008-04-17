%Regression; %uncomment to get a nice crasher :(
Features;
Classifier;
Kernel;

num=1000;
dist=1;
width=2.1
C=1
epsilon=1e-5

traindata_real=[randn(2,num)-dist, randn(2,num)+dist];
testdata_real=[randn(2,num)-dist, randn(2,num)+dist];

trainlab=[-ones(1,num), ones(1,num)];
testlab=[-ones(1,num), ones(1,num)];

feats_train=RealFeatures(traindata_real);
feats_test=RealFeatures(testdata_real);
feats_test.copy_feature_matrix(testdata_real);
kernel=GaussianKernel(feats_train, feats_train, width);

labels=Labels(trainlab);
svm=LibSVM(C, kernel, labels);
svm.set_epsilon(epsilon);
svm.train();
kernel.init(feats_train, feats_test);
out=svm.classify().get_labels();
testerr=mean(sign(out)~=testlab)
