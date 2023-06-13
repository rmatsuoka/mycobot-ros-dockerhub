FROM tiryoh/ros2-desktop-vnc:humble

ARG ROS_DISTRO=humble

USER root
RUN apt-get update && \
    apt-get install -y \
        python3-pip \
        ros-${ROS_DISTRO}-joint-state-publisher \
        ros-${ROS_DISTRO}-joint-state-publisher-gui \
        ros-${ROS_DISTRO}-moveit
RUN pip install pymycobot

USER ubuntu
RUN mkdir -p /home/ubuntu/colcon_ws/src
WORKDIR /home/ubuntu/colcon_ws/src
RUN git clone --depth 1 https://github.com/elephantrobotics/mycobot_ros2.git

WORKDIR /home/ubuntu/colcon_ws
RUN . /opt/ros/${ROS_DISTRO}/setup.bash && colcon build
RUN echo 'source /home/ubuntu/colcon_ws/install/setup.bash' >> /home/ubuntu/.bashrc

USER root
