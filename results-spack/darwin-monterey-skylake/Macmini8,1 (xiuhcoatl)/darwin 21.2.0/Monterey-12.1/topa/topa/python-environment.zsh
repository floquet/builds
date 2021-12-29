#!/bin/zsh
printf '%s\n' "$(date) $(tput bold)${HOME}/${(%):-%N}$(tput sgr0)"
# Thu Nov 25 15:16:10 MST 2021

# counts steps in batch process
export counter=0
function new_step(){
    counter=$((counter+1))
    echo ""
    echo "Step ${counter}: ${1}"
}

#   #   #   #   #   #   #   #   #   #   #
export            gcc_version="gcc@9.4.0"
export         python_version="python@3.8.12"
export space_weather_packages=('py-numpy' 'py-pandas' 'py-tqdm' 'py-urllib3' 'py-beautifulsoup4' 'py-matplotlib' 'py-gnuplot' 'py-plotly' 'py-seaborn' 'py-bokeh' 'py-geoplot' 'py-leather' 'py-scipy')

new_step "spack arch"
          spack arch

new_step "spack load ${gcc_version}"
          spack load ${gcc_version}

for p in ${space_weather_packages}; do
  new_step "spack install ${p} % ${gcc_version} ^${python_version}"
            spack install ${p} % ${gcc_version} ^${python_version}
done

new_step "print wall time used"
printf 'time for all builds: %dh:%dm:%ds\n' $(($SECONDS/3600)) $(($SECONDS%3600/60)) $(($SECONDS%60))

new_step "spack find"
          spack find

new_step "date"
          date
