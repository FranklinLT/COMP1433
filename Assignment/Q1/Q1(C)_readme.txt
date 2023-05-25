This R program uses Monte Carlo simulation to modling the problem C. In a single simulation, randomly generated 
numbers from 1 to 100 (with replacement) are used to represent each card and drawn 500 times, and the numbers "1" and "2" are 
used as the "Agrippa" and "Ptolemy" cards in the problem. The results were recorded each time. After a large number of simulations,
the probability was calculated based on each result.

During the simulation, the seed of each simulation is preset as the number of times for that simulation.

In this program, the preset number of simulations is 100,000, 200,000 and 500,000. After each simulation, the probability 
calculated for the corresponding number of times will be printed.

when
100,000 times:
P = 5e-05
200,000 times：
P = 4.5e-05
500,000 times:
P = 4.2e-05
Through observation, as the number of simulations increased, the data became closer and closer to the theoretical values.