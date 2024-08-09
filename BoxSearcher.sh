#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"



echo -e "

$greenColour                                         
                                         
                                         
                                         
                   ███░                  
               ▒████ ████▒               
            ████▓       ▓████            
         ████               ████                  ┳┓    ┏┓       ┓                 
         ██████           ██████                  ┣┫┏┓┓┏┗┓┏┓┏┓┏┓┏┣┓┏┓┏┓            
         ██  █████     █████  ██                  ┻┛┗┛┛┗┗┛┗ ┗┻┛ ┗┛┗┗ ┛             
         ██     ▓███████▓     ██          Hecho por:${redColour} https://github.com/Riieiro${greenColour}              
         ██        ███        ██          [+] Las máquinas estan sacadas de: ${redColour}https://htbmachines.github.io/${greenColour}              
         ██        ███        ██         
         ██        ███        ██         
         ████      ███      ████         
            ████▒  ███  ▒████            
               ▓█████████▓               
                  ░███░                  
                                         
                                         
                                         
                                         

"




sudo apt install jsbeautifier &>/dev/null

function crtl_c(){
	echo -e "${redColour}\n[!]Saliendo...\e[0m"
	exit 1
}

function updateFiles(){
  if [ ! -f bundle.js ]; then
    echo -e "${greenColour}\n[+] Descargando archivos necesarios...${endColour}"
    curl -s  $url > bundle.js
    js-beautify bundle.js | sponge bundle.js
  else
    echo -e "\n${greenColour}[+] Comprobando si hay actualizaciones...${endColour}"
    curl -s  $url > bundle_temp.js
    js-beautify bundle_temp.js | sponge bundle_temp.js 
    md5original=$(md5sum bundle.js | awk '{print $1}')
    md5temp=$(md5sum bundle_temp.js | awk '{print $1}')

    if [ "$md5original" == "$md5temp"  ];then
      echo -e "${greenColour}\n[+] No hay actualizaciones${endColour}"
      rm bundle_temp.js
    else
      curl -s  $url > bundle.js
      js-beautify bundle.js | sponge bundle.js
      rm bundle_temp.js
      echo -e "${greenColour}\n[+] Actualizado correctamente${endColour}"
    fi
  fi
}


#Ctrl+C
trap crtl_c INT 

# Variables globales
url="https://htbmachines.github.io/bundle.js"

function helpPanel(){
  echo -e  "${greenColour}\n[+] Uso: ${endColour}"
  echo -e  "\t${yellowColour}-a${endColour} ${redColour}Descargar${endColour}${grayColour} o ${redColour}actualizar${grayColour} archivos necesarios${endColour}"
  echo -e  "\t${yellowColour}-m${endColour} ${grayColour}Búsqueda por ${redColour}nombre de máquina${endColour}"
  echo -e "\t${yellowColour}-i${endColour} ${grayColour}Búsqueda por ${redColour}dirección IP${endColour}"
  echo -e "\t${yellowColour}-y ${endColour}${grayColour}Búsqueda por ${redColour}enlace${endColour}"
  echo -e "\t${yellowColour}-u${endColour} ${grayColour}Búsqueda de ${redColour}enlace youtube${endColour} ${grayColour}por nombre de máquina${endColour}"
  echo -e "\t${yellowColour}-o${endColour}${grayColour} Búsqueda por ${redColour}sistema operativo${endColour}"
  echo -e "\t${yellowColour}-s${endColour}${grayColour} Búsqueda por ${redColour}skill${endColour}"
  echo -e  "\t${yellowColour}-h ${endColour}${grayColour}Mostrar este ${redColour}panel de ayuda${endColour}"
}


#Indicadores
declare -i parameter_counter=0

function searchMachine(){
  machine="$1"
  echo ""

  cat bundle.js | awk "/name: \"$machine\"/,/resuelta/" | grep -vE "id|sku:|resuelta:" | tr -d ',' | tr -d '""' > machinetemp.txt

  contador=0

  machinechecker="$(cat bundle.js | awk "/name: \"$machine\"/,/resuelta/" | grep -vE "id|sku:|resuelta:" | tr -d ',' | tr -d '""')"
  if [ "$machinechecker" ]; then
    echo -e "${yellowColour}[+] ${grayColour}Mostrando el contenido de la máquina ${redColour}${machine}${grayColour}:${endColour}"
    echo ""

    while [ "$limite" != "x" ]
      do
        let contador+=1
        echo -e "${greenColour}$(sed " " machinetemp.txt  | awk '{print $1}' | tr -d ":" | awk -v contador="$contador" 'NR==contador')${endColour}${grayColour}$(cat machinetemp.txt  | awk '{$1=""; print $0}' | awk -v contador="$contador" 'NR==contador')"
        sed " " machinetemp.txt  | awk '{print $1}' | tr -d ":" | awk -v contador="$contador" 'NR==contador' > prueba_temp.txt 
        limite=$(cat prueba_temp.txt && echo x)
      done
  else
      echo -e "${redColour}[!] La máquina $machine no existe $endColour"
  fi
    rm machinetemp.txt prueba_temp.txt &>/dev/null
}

function searchIP(){
  ipAddress="$1"
  nombreIP=$(cat bundle.js | grep -B 3 "${ipAddress}" | head -n 1 | tr -d '""' | tr -d "," | awk '{print $2}')
  if [ "$nombreIP" ]; then
    echo ""
    echo -e "${yellowColour}[+] ${grayColour}La IP ${redColour}$ipAddress${endColour} ${grayColour}corresponde a la máquina ${redColour}$nombreIP${endColour}"
    searchMachine $nombreIP
  else
    echo -e "${redColour}[!] La IP $ipAddress no corresponde a ninguna máquina"
  fi
}

function searchURL(){
  youtube="$1"
  nombreURL=$(cat bundle.js | grep -B 8 "$youtube" | grep -vE "\-\-|id:|sku:|so:|ip:|dificultad|skills|resuelta:|\}\) lf.push\(\{|like:" | tr -d '""' | tr -d "," |  awk '{print $2}' | head -n 1) 
  echo ""
  if [ "$nombreURL" ]; then
    echo -e "${yellowColour}[+] ${grayColour}La url ${redColour}$youtube ${endColour}${grayColour}corresponde a la máquina ${redColour}$nombreURL${endColour}"
    searchMachine $nombreURL
  else
    echo -e "${redColour}[!] El enlace $youtube no corresponde a ninguna máquina $endColour"
  fi
}

function searchYT(){
  url="$1"
  nombreYT=$(cat bundle.js | grep -A 13 "$url" | grep -vE "\-\-|id:|sku:|so:|ip:|dificultad|skills|resuelta:|\}\) lf.push\(\{|like:|lf.push\(\{|name" | tr -d '""' | tr -d "," |  awk '{print $2}')
  echo ""
  if [ "$nombreYT" ]; then
    echo -e "${yellowColour}[+] ${grayColour}Puedes encontrar la máquina ${redColour}$url ${endColour}${grayColour}resuelta en ${redColour}$nombreYT"
  else
    echo -e "${redColour}[!] La máquina $url no existe $endColour"
  fi
}

function searchDI(){
  dificultad="$1"
  nombres=$(cat bundle.js | grep -B 5 "dificultad: \"$dificultad\"" | grep name | awk '{print $2}' | tr -d '"",')
  echo ""
  if [ "$nombres" ]; then
    if [ "$dificultad" == "Fácil" ]; then
      echo -e "${yellowColour}[+] ${grayColour}Mostrando las máquinas con dificultad ${greenColour}$dificultad\n"
    elif [ "$dificultad" == "Media" ]; then
      echo -e "${yellowColour}[+] ${grayColour}Mostrando las máquinas con dificultad ${yellowColour}$dificultad\n"
    elif [ "$dificultad" == "Difícil" ]; then
      echo -e "${yellowColour}[+] ${grayColour}Mostrando las máquinas con dificultad ${redColour}$dificultad\n"
    else
      echo -e "${yellowColour}[+] ${grayColour}Mostrando las máquinas con dificultad ${purpleColour}$dificultad\n"
    fi
      echo -e "${grayColour}$(cat bundle.js | grep -B 5 "dificultad: \"$dificultad\"" | grep name | awk '{print $2}' | tr -d '"",'| column)\n${endColour}"
  else
    echo -e "${redColour}[!] No existen máquinas con dificultad $dificultad"
  fi
}

function searchOS(){
  sistemaOperativo="$1"
  nombres=$(cat bundle.js | grep -B 5 "so: \"$sistemaOperativo\"" | grep name | awk '{print $2}' | tr -d '"",')
  echo ""
  if [ "$nombres" ]; then
    echo -e "${yellowColour}[+] ${grayColour}Mostrando las máquinas con el sistema operativo ${redColour}$sistemaOperativo"
    echo -e "${grayColour}\n$(cat bundle.js | grep -B 5 "so: \"$sistemaOperativo\"" | grep name | awk '{print $2}' | tr -d '"",'| column)"
  else
    echo -e "${redColour}[!] No existen máquinas con el sistema operativo $sistemaOperativo"
  fi
}


function getOSDIFF(){
  dificultad="$1"
  sistemaOperativo="$2"
  checker="$(cat bundle.js | grep -B 6 "dificultad: \"$dificultad\"" | grep -B 6 "so: \"$sistemaOperativo\"" | grep "name:" | awk '{print $NF}'| tr -d '"",')"
  if [ "$checker" ]; then
    echo ""
    if [ "$dificultad" == "Fácil" ]; then
      echo -e "${yellowColour}[+] ${grayColour}Mostrando las máquinas con dificultad ${greenColour}$dificultad${endColour} ${grayColour}y con el sistema operativo ${redColour}$sistemaOperativo\n"
    elif [ "$dificultad" == "Media" ]; then
      echo -e "${yellowColour}[+] ${grayColour}Mostrando las máquinas con dificultad ${yellowColour}$dificultad${endColour}${grayColour} y con el sistema operativo ${redColour}$sistemaOperativo\n"
    elif [ "$dificultad" == "Difícil" ]; then
      echo -e "${yellowColour}[+] ${grayColour}Mostrando las máquinas con dificultad ${redColour}$dificultad${endColour}${grayColour} y con el sistema operativo ${redColour}$sistemaOperativo\n"
    else
      echo -e "${yellowColour}[+] ${grayColour}Mostrando las máquinas con dificultad ${purpleColour}$dificultad${endColour}${grayColour} y con el sistema operativo ${redColour}$sistemaOperativo\n"
    fi

    echo -e "${grayColour}$(cat bundle.js | grep -B 6 "dificultad: \"Insane\"" | grep -B 6 "so: \"Windows\"" | grep "name:" | awk '{print $NF}'| tr -d '"",'| column)$endColour"
  else 
    echo ""
    echo -e "${redColour}[!] No existen máquinas con dificultad $dificultad y con el sistema operativo $sistemaOperativo $endColour"
  fi
}

function searchSK(){
  skill="$1"
  checker="$(cat bundle.js| grep -B 7 "${skill}" -i | grep -vE "like: " | grep "name: "| awk '{print $NF}' | tr -d '"",')"
  if [ "$checker" ]; then
    echo -e "\n${yellowColour}[+] ${grayColour}Mostrando las máquinas que contienen la skill ${redColour}$skill${endColour}"
    echo -e "\n${grayColour}$(cat bundle.js| grep -B 7 "${skill}" -i | grep -vE "like: " | grep "name: "| awk '{print $NF}' | tr -d '"",'| column)"
  else
     echo -e "\n${redColour}[!] No existen máquinas que contengan la skill $skill${endColour}"
  fi
}


# Chivatos
declare -i chivato_diff=0
declare -i chivato_os=0

while getopts "m:ai:hy:u:d:o:s:" argumento; do
  case $argumento in
    m) machineName=$OPTARG; let parameter_counter+=1;;
    a) let parameter_counter+=2;;
    i) ipAddress=$OPTARG; let parameter_counter+=3;;
    y) youtube=$OPTARG; let parameter_counter+=4;;
    u) url=$OPTARG; let parameter_counter+=5;;
    d) dificultad=$OPTARG; chivato_diff=1;let parameter_counter+=6;;
    o) sistemaOperativo=$OPTARG; chivato_os=1;let parameter_counter+=7;;
    s) skill=$OPTARG; let parameter_counter+=8;;
    h) ;;
  esac
done

if [ $parameter_counter -eq 1 ]; then 
  searchMachine $machineName
elif [ $parameter_counter -eq 2 ]; then
  updateFiles
elif [ $parameter_counter -eq 3 ]; then
  searchIP $ipAddress
elif [ $parameter_counter -eq 4 ]; then
  searchURL $youtube
elif [ $parameter_counter -eq 5 ]; then
  searchYT $url
elif [ $parameter_counter -eq 6 ]; then
  searchDI $dificultad
elif [ $parameter_counter -eq 7 ]; then
  searchOS $sistemaOperativo
elif [ $parameter_counter -eq 8 ]; then
  searchSK "$skill"
elif [ $chivato_diff -eq 1 ] && [ $chivato_os -eq 1 ]; then
  getOSDIFF $dificultad $sistemaOperativo
else
  helpPanel
fi
