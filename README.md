# FEM

Finite Elements Method to solve the problems associated with materials.

## 1.introduction

This project is aimed to calculate the displacement of the beam given force. Established on the theory FEM.

## 2. article reference

the project theory [theory reference](https://blog.qiql.net/archives/fem1>)
the project code structure reference [code structure reference](https://zhuanlan.zhihu.com/p/363678419)
the plot reference [plot reference] ()

## 3.function 

this part will introduce some key functions.

### B_calc

`b_calc` is used to calculate the matrix `B`.

#### function need

`none`

#### parameters input

`F` 4 nodes' coordinates matrix of the element. 8 x 1. 

`Simga_in`  x for the isoparametric elements' node. 

`Theta_in`  y for the isoparametric elements' node. 

#### return

`B` the element strain matrix. 3 X 8. 

`J` the Jaccobi matrix. 2 x 2.

### D_calc

`D_calc` is used to calculate the element material matrix D.

#### function need

`none`

#### parameters input

`E` young's modulus, Gpa. 

`v` possion proportion. 

#### return

`D` the element material matrix for 2 dimensions. 3 x 3.

### Ke_calc

`Ke_calc` is used to calculate the element stiffness matrix Ke.

#### function need

`B_calc`

`D_calc`

#### parameters input

`Ae` 4 nodes' coordinates of the element. 

`E` young's modulus. Gpa. 

`v` possion proportion. 

`t` the beam thickness.

#### return

`Ke` the element stiffness matrix Ke. 8 x 8.

### K_assemble

assemble the beam stiffness matrix `K` with the element stiffness matrix `Ke` . 

#### function need

`Ke_calc`

#### parameters input

`ele` matrix of the elements' index in the col 1 with 4 nodes' absolute index of the element in col 2~5.

`nodes_num` total nodes number.

`A_e`  matrix of nodes' coordinate which is ordered.

`E` young's modulus.

`v` possion proportion.

`position_constrain` the index of the nodes which are constrained.

#### return

`K` the beam stiffness matrix. 2 nodes_num x 2 nodes_num.

### P_calc

`P_calc` is used to calculate the beam's dF/dx.

#### function need

`none`

#### parameters input

`ele` matrix of the elements' index in the col 1 with 4 nodes' absolute index of the element in col 2~5.

`nodes_num` total nodes number.

`P_e` point F give on the nodes in the element.

`position_constrain` the index of the nodes which are constrained.

`K` the beam's stiffness matrix.

`A_t` the total nodes' coordinate which is ordered.

#### return 

`P` the beam's dF/dx.

### Param_Gen

order the nodes' coordinate and element's index with node's. This function has 2 mode to divide the beam.
We define the element length of horizon `delta x`, element length of vertical `delta y`. 

`mode 1` divides the beam into certain parts by `x axis`, every part's `y delta` equals to the beam `y delta`.Thus this mode only provides 1 dof, through the plot you will see element's `y delta` hold straight, which only shows the deformation of `x delta`.

`mode 2` divides the beam into certain parts by `x axis` and `y axis`. In this mode, every part (element) has 2 
dof, through the plot you will see element's `y delta` no longer hold straight, it also shows the deformation of `y delta`.

#### function need 

`none`

#### parameters input

`x` the beam length. e.g `x = 1:0.05:5`. 

`t` the beam width. In `mode 1`, it should be constant. e.g `t = 1.0`. In `mode 2`, it can be an array. e.g `t = 0:0.05:1`.

`mode` the working mode. it should be `1` or `2`.

#### return

`ele` every element's index with nodes'.

`A_e` matrix of nodes' coordinate which is ordered.

`nodes_num` total nodes number.

### beam_plot

This function can plot the beam inital state and final state. it also has 2 working mode.

`mode 1` plot the state in one plot.

`mode 2` plot the state in two subplots.

#### function need

`none`

#### paramters input

`A_i` nodes' initial coordinate.

`A_t` nodes' final coordinate.

`x` the beam's length.

`t` the beam's width.

`nodes_num` total nodes number.

`mode` the working mode. it should be `1` of `2`.

#### return

`state` if function is working, state = `1`, else state = `0`.











