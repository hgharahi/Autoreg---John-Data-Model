#!/bin/bash
# The interpreter used to execute the script

#“#SBATCH” directives that convey submission options:

#SBATCH --job-name=Control2
#SBATCH --mail-user=gharahih@umich.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=25
#SBATCH --mem-per-cpu=1000m 
#SBATCH --time=120:00:00
#SBATCH --account=beardda1
#SBATCH --partition=standard
#SBATCH --output=/home/%u/%x-%j.log
#SBATCH --output=matlab_parfor.out
#SBATCH --error=matlab_parfor.err

cd /home/gharahih/PzfControls/PzfSimulations/Control2/
module load matlab
matlab -nodisplay -r -noFigureWindows -nosplash "ParamEstALL" > Control2.out

sh rename.sh
