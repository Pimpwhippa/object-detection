## Dockerfile to build a docker image contain Darknet, OPENCV, and CUDA.
## Author : Pimpwhippa, Email:utrechtmay@gmail.com




FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

ARG https_proxy
ARG http_proxy


###  OPENCV INSTALL  ###

RUN apt-get update --fix-missing && apt-get install -qy \
	cmake \
	python-numpy python-scipy python-pip python-setuptools \
	python3-numpy python3-scipy python3-pip python3-setuptools \
	wget \
	xauth \

# Build OpenCV 3.4.4
RUN \
	#cd /root && \
	apt-get update \
	apt-get upgrade \
	apt-get install build-essential cmake unzip pkg-config \
	apt-get install libjpeg-dev libpng-dev libtiff-dev \
	apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
	apt-get install libxvidcore-dev libx264-dev \
	apt-get install libgtk-3-dev \
	apt-get install libatlas-base-dev gfortran \
	apt-get install python3-dev \
	cd ~ \
	wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.4.zip \
	wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.4.zip \
	unzip opencv.zip \
	unzip opencv_contrib.zip \
	mv opencv-3.4.4 opencv \
	mv opencv_contrib-3.4.4 opencv_contrib \
	wget https://bootstrap.pypa.io/get-pip.py \
	python3 get-pip.py \
	pip install virtualenv virtualenvwrapper \
	rm -rf ~/get-pip.py ~/.cache/pip \
	export WORKON_HOME=$HOME/.virtualenvs \
	export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3 \
	source /usr/local/bin/virtualenvwrapper.sh \
	echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc \
	echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc \
	echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc \
	echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc \
	source ~/.bashrc \
	mkvirtualenv cv -p python3 \
	workon cv \
	pip install numpy \
	cd ~/opencv \
	mkdir build \
	cd build \
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D INSTALL_C_EXAMPLES=OFF \
	-D OPENCV_ENABLE_NONFREE=ON \
	-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
	-D WITH_CUDA=ON \
	-D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-8.0 \
	-D PYTHON_EXECUTABLE=~/.virtualenvs/cv/bin/python \
	-D BUILD_EXAMPLES=ON .. \
	-D BUILD_opencv_python3=ON \
	
	.. && make && make install && \

	mv cv2.cpython-36m-x86_64-linux-gnu.so cv2.so \
	cd ~/.virtualenvs/cv/lib/python3.6/site-packages/ \
	ln -s /usr/local/python/cv2/python-3.6/cv2.so cv2.so \   

	cd /root && rm -rf opencv.zip opencv_contrib.zip \
	rm -rf opencv opencv_contrib
	

###  DARKNET INSTALL  ###
RUN     apt-get -qy install git-core

RUN  	cd / \
	&& git clone https://github.com/pjreddie/darknet \
	&& cd darknet \
	&& sed -i 's/GPU=0/GPU=1/g' Makefile \
	&& sed -i 's/OPENCV=0/OPENCV=1/g' Makefile \
	&& make 

###Download YOLO v3 tiny weights  
RUN 	cd / \
	&& mkdir weights && cd /weights \
	&& wget https://pjreddie.com/media/files/yolov3-tiny.weights 

#RUN   	export PATH=$PATH:/darknet/darknet
RUN apt-get install -qqy x11-apps 



WORKDIR /darknet
#uncomment the following line to prevent runing docker image alongwith the darknet executable file
#ENTRYPOINT [ "./darknet", "detect" , "/darknet/uptogithub/yolov3-tiny.cfg" , "/darknet/uptogithub/weights/yolov3-tiny.weights" , "/darknet/uptogithub/testimages/snake-medicine.jpg" ] 

