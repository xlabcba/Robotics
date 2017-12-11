% TODO: You write this function!
% input: f1 -> an 9-joint robot encoded as a SerialLink class for one
%              finger
%        f2 -> an 9-joint robot encoded as a SerialLink class for one
%              finger
%        qInit -> 1x11 vector denoting current joint configuration.
%                 First six joints are the arm joints. Joints 8,9 are
%                 finger joints for f1. Joints 10,11 are finger joints
%                 for f2.
%        f1Target, f2Target -> 3x1 vectors denoting the target positions
%                              each of the two fingers.
% output: q -> 1x11 vector of joint angles that cause the fingers to
%              reach the desired positions simultaneously.
%              (orientation is to be ignored)
function q = Q3(f1,f2,qInit,f1Target,f2Target)
    % Set increment factor
    alpha = 0.05;
    
    % Set rotation matrix as Indentity Matrix
    R = eye(3);
    NULL  = [0 0; 0 0; 0 0; 0 0; 0 0; 0 0];

    % Set homogeneous transformation for desired positions
    f1Target = [R  f1Target; 0 0 0 1]; % Finger1
    f2Target = [R  f2Target; 0 0 0 1]; % Finger2

    % Set initial joint angle
    q = qInit;
    
    % Loop to increment to desired position
    for i=1:80
        % Get current angles
        qf1 = [q(1:1, 1:7) q(1:1,  8: 9)];   % 1 * 9
        qf2 = [q(1:1, 1:7) q(1:1, 10:11)];   % 1 * 9 
    
        % Calculate current positions
        pf1 = f1.fkine(qf1);                 % 1 * 1
        pf2 = f2.fkine(qf2);                 % 1 * 1
    
        % Calculate displacement between current and desired positions
        dXf1 = tr2delta(pf1, f1Target);      % 6 * 1
        dXf2 = tr2delta(pf2, f2Target);      % 6 * 1
        dX   = [dXf1; dXf2];                 % 12 * 1
    
        % Calculate Jacobian
        Jf1  = f1.jacob0(qf1);               % 6 * 9
        Jf1  = [Jf1(:,1:7) Jf1(:,8:9) NULL]; % 6 * 11
        Jf2  = f2.jacob0(qf2);               % 6 * 9
        Jf2  = [Jf2(:,1:7) NULL Jf2(:,8:9)]; % 6 * 11
        J    = [Jf1; Jf2];                   % 12 * 11
    
        % Calculate Jacobian inverse
        Ji   = pinv(J);                      % 11 * 12
    
        % Find delta Q
        dQ = alpha * Ji * dX;                % 11 * 1
        q  = dQ' + q;
    end
end


