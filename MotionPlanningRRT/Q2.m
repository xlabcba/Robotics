% Calculate a path from qStart to xGoal
% input: qStart -> 1x4 joint vector describing starting configuration of
%                   arm
%        xGoal -> 3x1 position describing desired position of end effector
%        sphereCenter -> 3x1 position of center of spherical obstacle
%        sphereRadius -> radius of obstacle
% output -> qMilestones -> 4xn vector of milestones. A straight-line interpolated
%                    path through these milestones should result in a
%                    collision-free path. You may output any number of
%                    milestones. The first milestone should be qStart. The
%                    last milestone should place the end effector at xGoal.
function qMilestones = Q2(rob,sphereCenter,sphereRadius,qStart,xGoal)
    
    % Constants
    MIN_STEP_LEN = 0.01;
    DEBUG_PLOT_TREE = true;
    DEBUG_PLOT_PATH = true;
    
    % Loop end flag
    reached = false;
    
    % Buffer radius
    bufferedR = sphereRadius * 1.3;
    
    % Calculate position goal
    qGoal = rob.ikine(transl(xGoal), zeros(1,4), [1,1,1,0,0,0]);
    
    % Plot xGoal
    scatter3(xGoal(1), xGoal(2), xGoal(3), 'filled');
    
    % Initialize tree & parent
    tree = [qStart];
    parent = [-1];
    
    while ~reached
        % Sample random node
        qr = getRandomNode(qGoal);
        
        % Find nearest node in tree
        index = getNearestNode(tree, qr); 
        qn = tree(index,:);
        
        % Try to connect if new node is goal
        if qr == qGoal
            collision = Q1(rob, qn, qGoal, sphereCenter, bufferedR);
            if ~collision
                % Add to tree & parent if no collision
                tree   = [tree; qr];
                parent = [parent; index];
                reached = true;
                continue;
            end
        end
        
        % Calculate distance
        dist = norm(qn - qr);
        
        % Ignore node too close
        if(dist < MIN_STEP_LEN)
            continue;
        end
        
        % One step from qn to qr 
        qr = makeOneStep(qn, qr, dist);
        
        % Ignore if collision
        collision = Q1(rob, qn, qr, sphereCenter, bufferedR);
        if ~collision
        	% Add to tree & parent if no collision
            tree   = [tree; qr];
            parent = [parent; index];
            if DEBUG_PLOT_TREE
                plotTreeNode(rob, qr);
            end
        end
    end
    
    % Retrieve path from tree
    qMilestones = [];
    [index, ~] = size(tree);  
    while (index ~= -1)
        qMilestones = [tree(index,:); qMilestones];
        index = parent(index);
    end
    
    if DEBUG_PLOT_PATH
        plotPath(rob, qMilestones);
    end

    qMilestones;
end

function qrand = getRandomNode(qGoal)
    if rand < 0.9 
        % goal = mod(rand(size(qGoal))*15, 4*pi)-2*pi;
        qrand = ((rand(size(qGoal)) * (2*pi)) - pi);
    else 
        % Sample as goal with 10% prob.
        qrand = qGoal;
    end
    
    qrand;
end

function index = getNearestNode(tree, qr)
    % Displacement for each node in tree
    disp = bsxfun(@minus, tree, qr);
    % Distance for each node in tree
    dist = sqrt(sum(disp.^2,2));
    % Index of node corresp. to min distance
    [~, index] = min(dist);
    
    index;
end

function qnew = makeOneStep(qn, qr, dist)
    % Constants
    MAX_STEP_LEN = 0.1;
    
    % Make one step from qn to qr 
    % less than MAX_STEP_LEN
    if dist > MAX_STEP_LEN
        pntNo = ceil(dist/MAX_STEP_LEN);
        [~, jntDim] = size(qn);
        q = zeros(jntDim, pntNo);
        for i=1:jntDim
            q(i,:) = linspace(qn(i), qr(i), pntNo);
        end
        qnew = q(:,2);
        qnew = qnew';
    else
        qnew = qr;
    end
    
    qnew;
end

function plotTreeNode(rob, qr)
	p = rob.fkine(qr);
	p = p(1:3,4);
	scatter3(p(1), p(2), p(3), '.');
end

function plotPath(rob, qMilestones)
	path = [];
	[pathLen,~] = size(qMilestones);
	for i = 1:pathLen
        p = rob.fkine(qMilestones(i,:));
        p = p(1:3,4);
        path = [path p];
	end
	plot3(path(1,:),path(2,:),path(3,:),'o-');    
end