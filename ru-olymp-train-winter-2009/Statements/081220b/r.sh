#!/bin/bash
latex problems
dvips -t landscape problems
dvipdfm -p a4 problems
