% 
% This function takes two joint configurations and the parameters of the
% obstacle as input and calculates whether a collision free path exists
% between them.
% 
% input: q1, q2 -> start and end configuration, respectively. Both are 1x4
%                  vectors.
%        sphereCenter -> 3x1 position of center of sphere
%        r -> radius of sphere
%        rob -> SerialLink class that implements the robot
% output: collision -> binary number that denotes whether this
%                      configuration is in collision or not.
function collision = Q1(rob,q1,q2,sphereCenter,r)

    % Constants
    PNT_NO = 10; % Number of points evenly separated as a line
    [~, JNT_DIM] = size(q1); % Joint dimension
    
    % Initialize return value
    collision = false;
    
    % Generate straight path between q1 & q2
    % Each row i corresponds to a joint dimension i in [1,JNT_DIM]
    % Each column j corresponds to a point on the path j in [1,PNT_NO]
    q = zeros(JNT_DIM, PNT_NO);
    for i=1:JNT_DIM
        q(i,:) = linspace(q1(i), q2(i), PNT_NO);
    end
    q = q';
    
    % For each point on the path, check collision or not
    for i=1:PNT_NO
        collision = robotCollision(rob, q(i,:), sphereCenter, r);
        if collision
            break;
        end;
    end;
end

