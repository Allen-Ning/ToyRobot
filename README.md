# Toy Robot Simulator



## Rules

- A toy robot is free to move on a board - default 5 units x 5 units.
- There are no obstructions on the table surface.
- Any command that would cause the robot to move off the table should be ignored.
- Any command before a valid PLACE command should be ignored.

## Commands

#### PLACE X,Y,F

Places the robot on the table, must accept valid placement (X,Y) and a facing direction (F).</br> 

**Please notice X,Y must be interger numbers and PLACE must be using all capital letters** 

#### MOVE

Moves the robot forward one space at a time.<br/>

**Please notice MOVE must be using all capital letters**

#### LEFT

Rotates the robot 90° left.<br/>

**Please notice LEFT must be using all capital letters**

#### RIGHT

Rotates the robot 90° right.<br/>

**Please notice RIGHT must be using all capital letters**

#### REPORT

Displays the current placement and direction the robot is facing.<br/>

**Please notice RIGHT must be using all capital letters**

## Installation

```
git clone https://github.com/Allen-Ning/ToyRobot
cd ToyRobot
gem install bundler
bundle install
```

## Tests

Tests can be run with the:

```
cd ToyRobot
rspec spec
```

