#!/usr/bin/env bash
cd /vol/app/ || exit

poetry run pytest -v --cov --cov-report=xml
mv coverage.xml /vol/app/.ci_reports/coverage.xml
