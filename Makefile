include Makefile.include

test_vsim_environment:
	@helper_scripts/test_vsim_environment.csh

setup:
	@helper_scripts/setup_design.sh ${DESIGN} ${CELL_EXP_LOC} ${PARAMS}

prepare:
	@helper_scripts/prepare_sim.sh ${DESIGN} ${EXP_FILE}

simulate:
	@helper_scripts/run_sim.sh ${DESIGN} ${SIM_SCENARIO_CONFIG} ${EXP_FILE} ${NUM_PROC}

evaluate:
	@helper_scripts/eval.sh ${DESIGN}

multi_eval:
	@helper_scripts/meval.sh ${DESIGN} ${EXPLST_FILE}

analyze:
	@helper_scripts/analyze.sh ${DESIGN} ${RES_FILE}
