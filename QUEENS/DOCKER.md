# Docker usage for QUEENS

1. First build the docker container using
   
    ```bash
    docker build -f Dockerfile . --tag="ukacm_gacm"
    ```

1. Start the docker via:

    ```bash
    docker run -it -p 8888:8888 ukacm_gacm
    ```

1. In the docker shell run
   
    ```bash
    jupyter notebook --ip 0.0.0.0 --port 8888 --no-browser --allow-root
    ```

    Now, a message will appear:

    ```
        To access the server, open this file in a browser:
            file:///home/user/.local/share/jupyter/runtime/jpserver-20-open.html
        Or copy and paste one of these URLs:
            http://ad553d029988:8888/tree?token=0d21235e0e799e5242e2e08800992e49830c18f379f6d38c
            http://127.0.0.1:8888/tree?token=0d21235e0e799e5242e2e08800992e49830c18f379f6d38c
    ```

1. Open the last link in your browser and you are good-to-go