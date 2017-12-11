% TODO: You write this function!
% input: f -> a 9-joint robot encoded as a SerialLink class
%        qInit -> 1x9 vector denoting current joint configuration
%        posGoal -> 3x1 vector denoting the target position to move to
% output: q -> 1x9 vector of joint angles that cause the end
%                     effector position to reach <position>
%                     (orientation is to be ignored)
function q = Q2(f,qInit,posGoal)
    % Set increment factor
    alpha = 0.5;
    
    % Set rotation matrix as Indentity Matrix (as orientation is ignored)
    R = eye(3);
    
    % Set homogeneous transformation for desired position
    % posGoal = [R posGoal; 0 0 0 1];
    
    % Set initial joint angle
    q = qInit;
    
    % Loop to increment to desired position
    for i=1:80
        % Calculate displacement between current and desired end effector
        p = transl(f.fkine(q))'; 
        display('size P:')
        display(size(p))
        % dX = tr2delta(p, posGoal);
        errX = norm(p - posGoal)
        dX = posGoal - p
        
        % Calculate inverse Jacobian
        J = f.jacob0(q, 'trans');
        display('size J:')
        display(size(J))
        Ji = pinv(J);
        
        % Calculate increment joint angles
        dQ = alpha * Ji * dX;
        q  = q + dQ';
        display('size q:')
        display(size(q))
    end
end


