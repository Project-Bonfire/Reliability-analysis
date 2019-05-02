# Copyright (C) 2015 Siavoosh Payandeh Azad
#
# Modifications by Karl Janson in 2019:
#   - Removed functions not needed by the current toolchain
#   - Converted to Python3
#

################################################
#          Internal Variables
################################################
LoGDirectory = "LOGS"
################################################
#          Turn Model Sets
################################################
FULL_TurnModel_2D = ['E2N', 'E2S', 'W2N', 'W2S', 'S2W', 'S2E', 'N2W', 'N2E']
FULL_TurnModel_3D = ['E2N', 'E2S', 'W2N', 'W2S', 'S2W', 'S2E', 'N2W', 'N2E',
                     'N2U', 'N2D', 'S2U', 'S2D', 'W2U', 'W2D', 'E2U', 'E2D',
                     'U2N', 'U2S', 'U2E', 'U2W', 'D2N', 'D2S', 'D2E', 'D2W']

# 2D Turn Models:
XY_TurnModel = ['E2N', 'E2S', 'W2N', 'W2S']
YX_TurnModel = ['S2W', 'S2E', 'N2W', 'N2E']
WestFirst_TurnModel = ['E2N', 'E2S', 'W2N', 'W2S', 'S2E', 'N2E']
NorthLast_TurnModel = ['E2N', 'E2S', 'W2N', 'W2S', 'N2W', 'N2E']
NegativeFirst2D_TurnModel = ['E2N', 'E2S', 'W2N', 'S2E', 'W2S', 'N2E']

# 3D Turn Models:
XYZ_TurnModel = ['E2N', 'E2S', 'W2N', 'W2S', 'S2U', 'S2D', 'N2U', 'N2D', 'W2U', 'W2D', 'E2U', 'E2D']

# based on description in "Turn model based router design for 3D network on chip" by Chemli and Zitouni
NegativeFirst3D_TurnModel = ['E2N', 'E2S', 'W2N', 'W2S', 'S2E', 'N2E',
                             'N2U', 'N2D', 'S2U', 'S2D', 'E2U', 'E2D', 'W2U', 'W2D',
                             'U2N', 'U2S', 'U2E', 'D2S', 'D2N', 'D2E']

routing_alg_list_2d = [YX_TurnModel, XY_TurnModel, WestFirst_TurnModel, NorthLast_TurnModel, NegativeFirst2D_TurnModel]
routing_alg_list_3d = [XYZ_TurnModel, NegativeFirst3D_TurnModel]
################################################
#          SHM Sets
################################################
TurnsHealth_2DNetwork = {"N2W": True, "N2E": True, "S2W": True, "S2E": True,
                         "W2N": True, "W2S": True, "E2N": True, "E2S": True}

# TurnsHealth for conventional 3D NoC
TurnsHealth_3DNetwork = {"N2W": True, "N2E": True, "S2W": True, "S2E": True,
                         "W2N": True, "W2S": True, "E2N": True, "E2S": True,
                         "N2U": True, "N2D": True, "S2U": True, "S2D": True,
                         "W2U": True, "W2D": True, "E2U": True, "E2D": True,
                         "U2W": True, "U2E": True, "U2N": True, "U2S": True,
                         "D2W": True, "D2E": True, "D2N": True, "D2S": True}

