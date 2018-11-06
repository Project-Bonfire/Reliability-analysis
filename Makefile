include Makefile.include

test_vsim_environment:
	@helper_scripts/test_vsim_environment.csh

setup:
	@helper_scripts/setup_design.sh ${DESIGN} ${CELL_EXP_LOC} ${PARAMS}
