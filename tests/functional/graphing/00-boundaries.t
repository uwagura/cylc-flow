#!/usr/bin/env bash
# THIS FILE IS PART OF THE CYLC WORKFLOW ENGINE.
# Copyright (C) NIWA & British Crown (Met Office) & Contributors.
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------
# Test graphing for a workflow with two different cycling intervals.
. "$(dirname "$0")/test_header"
#-------------------------------------------------------------------------------
set_test_number 3
#-------------------------------------------------------------------------------
install_workflow "${TEST_NAME_BASE}" "${TEST_NAME_BASE}"
#-------------------------------------------------------------------------------
TEST_NAME="${TEST_NAME_BASE}-validate"
run_ok "${TEST_NAME}" cylc validate "${WORKFLOW_NAME}"
#-------------------------------------------------------------------------------
# Two tests:
for POINT in 20140808T00 20140808T06; do
    TEST_NAME="${TEST_NAME_BASE}-graph-${POINT}"
    graph_workflow "${WORKFLOW_NAME}" "${POINT}.graph.plain" "${POINT}"
    cmp_ok "${POINT}.graph.plain" \
        "${TEST_SOURCE_DIR}/${TEST_NAME_BASE}/${POINT}.graph.plain.ref"
done
#-------------------------------------------------------------------------------
purge
