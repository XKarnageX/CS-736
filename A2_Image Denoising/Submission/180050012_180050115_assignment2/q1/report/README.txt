For optimization of the parameters alpha and gamma, we first optimised the results on alpha and then gamma as the RRMSE values of the optimised images seemed to change steeper with changing the alpha values.

We varied alpha from 0 to 1 with a step size of 0.02 and accepted the value of alpha which gave us a minima for the RRMSE value wrto the noiseless image.
We then varied gamma exponentially from 1 to 2^20, which gave RRMSE as an increasing function. So we then varied gamma grom 0.1 to 3 in steps of 0.1 to attain its optimal value.


We had implemented both sequential and parallel methods for gradient descent but for the given data, our sequential grad descent gave better results over the parallel grad descent algorithm, so we deceided to go with the sequential algorithm.