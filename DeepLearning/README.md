# Deep Learning Classification by Convolutional Neural Networks (LeNet)

## Convolutional Neural Network (CNN) Introduction
see [DeepLearningTutorial](http://deeplearning.net/tutorial/lenet.html#the-full-model-lenet)

### Motivation

>Convolutional Neural Networks (CNN) are biologically-inspired variants of MLPs. 

>Visual cortex contains a complex arrangement of cells. These cells are sensitive to small sub-regions of the visual field, called a receptive field. The sub-regions are tiled to cover the entire visual field. These cells act as local filters over the input space and are well-suited to exploit the strong spatially local correlation present in natural images.

>Additionally, two basic cell types have been identified: Simple cells respond maximally to specific edge-like patterns within their receptive field. Complex cells have larger receptive fields and are locally invariant to the exact position of the pattern.
The animal visual cortex being the most powerful visual processing system in existence, it seems natural to emulate its behavior.

### Features

**1. Sparse Connectivity**

>CNNs exploit spatially-local correlation by enforcing a local connectivity pattern between neurons of adjacent layers. In other words, the inputs of hidden units in layer m are from a subset of units in layer m-1, units that have spatially contiguous receptive fields. We can illustrate this graphically as follows:

<p align="center"><img src="https://github.com/xlabcba/Robotics/blob/master/DeepLearning/figures/SparseConnectivity.png"/></p>

>Imagine that layer m-1 is the input retina. In the above figure, units in layer m have receptive fields of width 3 in the input retina and are thus only connected to 3 adjacent neurons in the retina layer. Units in layer m+1 have a similar connectivity with the layer below. We say that their receptive field with respect to the layer below is also 3, but their receptive field with respect to the input is larger (5). Each unit is unresponsive to variations outside of its receptive field with respect to the retina. The architecture thus ensures that the learnt “filters” produce the strongest response to a spatially local input pattern.

**2. Shared Weights**

>In CNNs, each filter h<sub>i</sub> is replicated across the entire visual field. These replicated units share the same parameterization (weight vector and bias) and form a *feature map*.

<p align="center"><img src="https://github.com/xlabcba/Robotics/blob/master/DeepLearning/figures/FeatureMap.png"/></p>

>In the above figure, we show 3 hidden units belonging to the same feature map. Weights of the same color are shared—constrained to be identical. Gradient descent can still be used to learn such shared parameters, with only a small change to the original algorithm. The gradient of a shared weight is simply the sum of the gradients of the parameters being shared.

>Replicating units in this way allows for features to be detected regardless of their position in the visual field. Additionally, weight sharing increases learning efficiency by greatly reducing the number of free parameters being learnt. The constraints on the model enable CNNs to achieve better generalization on vision problems.

**3. MaxPooling**

>Another important concept of CNNs is max-pooling, which is a form of non-linear down-sampling. Max-pooling partitions the input image into a set of non-overlapping rectangles and, for each such sub-region, outputs the maximum value.

>Max-pooling is useful in vision for two reasons:
> By eliminating non-maximal values, it reduces computation for upper layers.
> It provides a form of translation invariance. Imagine cascading a max-pooling layer with a convolutional layer. There are 8 directions in which one can translate the input image by a single pixel. If max-pooling is done over a 2x2 region, 3 out of these 8 possible configurations will produce exactly the same output at the convolutional layer. For max-pooling over a 3x3 window, this jumps to 5/8.

>Since it provides additional robustness to position, max-pooling is a “smart” way of reducing the dimensionality of intermediate representations.

### Full Model: LeNet

>Sparse, convolutional layers and max-pooling are at the heart of the LeNet family of models. While the exact details of the model will vary greatly, the figure below shows a graphical depiction of a LeNet model.

<p align="center"><img src="https://github.com/xlabcba/Robotics/blob/master/DeepLearning/figures/LeNet.png"/></p>

>The lower-layers are composed to alternating convolution and max-pooling layers. The upper-layers however are fully-connected and correspond to a traditional MLP (hidden layer + logistic regression). The input to the first fully-connected layer is the set of all features maps at the layer below.

## Folder Structure

* **[homework4.pdf](https://github.com/xlabcba/Robotics/blob/master/DeepLearning/homework4.pdf)** - Description of 3 programming questions related to Deep Learning.
* **[hw4.m](https://github.com/xlabcba/Robotics/blob/master/DeepLearning/hw4.m)** - Function to run solution to each question by giving corresponding question number.
* **[Q1.m](https://github.com/xlabcba/Robotics/blob/master/DeepLearning/Q1.m)** - This function implements a convolutional neural network that can be trained to classify MNIST digits.
* **[Q2.m](https://github.com/xlabcba/Robotics/blob/master/DeepLearning/Q2.m)** - This function implements a convolutional neural network that can be trained to classify 26 English letters.
* **[Q3.m](https://github.com/xlabcba/Robotics/blob/master/DeepLearning/Q3.m)** - This function speeds up learning for letter classification by finetuning a network that was pretrained on the MNIST digit classification task (Q1).
* **[emnist-mnist.mat](https://github.com/xlabcba/Robotics/blob/master/DeepLearning/emnist-mnist.mat)** - MINIST digits, which is 28 * 28 grayscale training data for Q1 & Q3.
* **[emnist-letters.mat](https://github.com/xlabcba/Robotics/blob/master/DeepLearning/emnist-letters.mat)** - MINIST letters, which is 28 * 28 grayscale training data for Q2.
* **[neural_networks.pdf](https://github.com/xlabcba/Robotics/blob/master/DeepLearning/neural_networks.pdf)** - Slides as implementation reference.

## Run Instruction:
1. Put hw4.m & Q1.m & Q2.m & Q3.m into MATLAB
2. Load corresponding training data into same folder
3. In MATLAB terminal, run
```
 $ startup_rvc
```
4. In MATLAB terminal, run following to show corresponding programming solutions
```
 $ hw4($QuestionNumber)
```