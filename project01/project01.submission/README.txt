README FILE for submission Project 1
====================================

* CISC 810 - Quantitative Foundation
  Rochester Institute of Technology
  September 25, 2018

* Project 1:  Linear Feature Engineering
  Students:   Valdecantos Hector - Wagh Gaurav
  Instructor: Linwei Wang

This is a Matlab project ..

CONTENT:

  [cv_k_fold.m]
  Main script file that implements the K-fold cross-validation procedure to
  estimate the goodness of a model.
 
  [back_subtitute.m]
  Function that implements the back substitution method given an
  upper-triangular system, i.e. the A matrix and the right-hand side vector b.

  [expand.m]
  Function that implements the expansion of X into Z matrix depending on the
  function terms given.

  [get_fold_sizes.m]
  Function that returns a vector of sizes depending on the size of the X data
  set and number of folds to implement.
 
  [get_folds.m]
  Function that returns the training and test sets given a current k iteration
  on a k-fold method.

  [get_polynomial.m]
  Function that given the order and the variables involved in a general multi
  variable polynomial form will return the polynomial written as separate
  anonymous functions for each of its term along with an index designating the
  variable that applies to that term.

  [least_squares.m]
  Function that uses the Gaussian elimination method by reducing a linear
  system into an upper-triangular and then solve the system by
  back-substitution. It returns the sum of square error (R) and the weights
  coefficients.

  [plot_errors.m]
  Function to plot a series of points with a mark (*) link with a line, used to
  graph the Sum of Squared Errors (R) of training and test sets.

  [testinputs.txt]
  Data with 103 rows, each with 8 numbers representing the test input from
  which the response variable the project predicts.

  [traindata.txt]
  Data with 926 rows, each with 8 numbers representing the real-valued
  predictors along together with a 9th number for a real-valued response value.

  [triangularize.m]
  Function that given a linear system Ax=b in the form of a matrix (A|b), will
  return an upper-triangular system (A'|b').

INSTRUCTIONS:

  1. Open Matlab and set the project path to the folder containing these
     above mentioned files.
  2. Doble-click the main file [cv_k_fold.m] to open it on the editor area.
  3. Execute or run the file by clicking on the run button or pressing F5 key.
  4. A figure with the average Rs for each polynomial order will pop-up.
  5. A file named 'predicted_values.txt' will be written in the same project
     directory with the 103 prediction based on the proposed model.
     