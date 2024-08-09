# BoxSearcher
![image](https://github.com/user-attachments/assets/1e22e43c-76d8-42f7-adaf-360c2bf997ae)

Herramienta para hacer búsquedas locales de laboratorios Hack The Box.

### Descripción

`BoxSearcher.sh` es un script diseñado para hacer búsquedas locales de laboratorios Hack The Box. Esta herramienta, permite al usuario filtrar por nombre, sistema operativo, dificultad y skill. 

### Características

- **Búsqueda por nombre**: Permite filtrar por el nombre de una máquina, mostrando los detalles de la misma.
- **Búsqueda por sistema operativo**: Permite filtrar por el sistema operativo, mostrando los nombres de todas las máquinas con el sistema operativo mencionado.
- **Búsqueda por dificultad**: Permite filtrar por la dificultad, mostrando los nombres de todas las máquinas con la dificultad mencionada.
- **Búsqueda por skill**: Permite filtrar por skill, mostrando los nombres de todas las máquinas en las que se utiliza la skill mencionada.
### Uso

Para usar el script `BoxSearcher.sh`, sigue estos pasos:

1. **Clonar el Repositorio**:

    ```bash
    git clone https://github.com/Riieiro/BoxSearcher
    cd BoxSearcher
    ```

2. **Dar Permisos de Ejecución al Script**:

   ```bash
    chmod +x BoxSearcher.sh
    ```

3. **Ejecutar el Script**:
 
    ```bash
    sudo ./BoxSearcher.sh
    ```

### Requisitos

- Sistema operativo Linux.
- Permisos de superusuario (root) para ejecutar ciertas configuraciones del script.

### ¿Cómo funciona?

A continuación, un ejemplo de cómo se podría utilizar el script:

![image](https://github.com/user-attachments/assets/6f789c92-cb8a-4ffc-ae35-087ad5513075)

Para empezar a útilizar la herramienta por primera vez necesitaremos instalar unos archivos necesarios de la página https://htbmachines.github.io/
    
    ```bash
    ./BoxSearcher.sh -a
    ```
![image](https://github.com/user-attachments/assets/4a22e25f-0779-44ea-8de2-cb04cba636ae)

Una vez instalado los archivos necesarios podemos ver las opciones:
    
    ```bash
    ./BoxSearcher.sh -h
    ```
![image](https://github.com/user-attachments/assets/f69d3169-13ac-4aa2-9379-372f6ba7d480)

1. Búsqueda por nombre de máquina

   ```bash
    ./BoxSearcher.sh -m <Nombre de la máquina>
    ```
![image](https://github.com/user-attachments/assets/09b32a31-36ff-4fd9-a85e-ddfe6db8027b)

2. Búsqueda por sistema operativo

    ```bash
    ./BoxSearcher.sh -o <Sistema operativo>
    ```
![image](https://github.com/user-attachments/assets/70d4e46d-301d-4a79-bf56-8f0cfd779379)

3. Búsqueda por dificultad

    ```bash
    ./BoxSearcher.sh -d <Dificultad>
    ```

![image](https://github.com/user-attachments/assets/e2c0524b-570c-49a1-a8a1-02d7bd7b41ac)

4. Búsqueda por skill

    ```bash
    ./BoxSearcher.sh -s <"Skill">
    ```

![image](https://github.com/user-attachments/assets/85749992-004e-4e49-80a1-2f21e37eb8da)

5. Búsqueda por dificultad y sistema operativo

    ```bash
    ./BoxSearcher.sh -d <Dificultad> -o <Sistema operativo>
    ```
![image](https://github.com/user-attachments/assets/bd089213-3230-4e97-8ece-fb948ffab939)
