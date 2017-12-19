% Smooth path given in qMilestones
% input: qMilestones -> nx4 vector of n milestones. 
%        sphereCenter -> 3x1 position of center of spherical obstacle
%        sphereRadius -> radius of obstacle
% output -> qMilestones -> 4xm vector of milestones. A straight-line interpolated
%                    path through these milestones should result in a
%                    collision-free path. You should output a number of
%                    milestones m<=n.
function qMilestonesSmoothed = Q3(rob,qMilestones,sphereCenter,sphereRadius)

    % Constants
    DEBUG_PLOT_PATH = true;
    
    % Buffer radius
    bufferedR = sphereRadius * 1.3;
    
    % Initialize smooth path
    qMilestonesSmoothed = qMilestones;

    % Initialize end index to start search
    [endIdx,~] = size(qMilestonesSmoothed);
    
    % Loop to find non-collision path by fixing end
    finished = false;
    while ~finished
        qEnd = qMilestonesSmoothed(endIdx,:);
        found = false;
        % Search from very start until non-collision path to curr end
        for startIdx=1:endIdx-2
            qStart = qMilestonesSmoothed(startIdx,:);
            collision = Q1(rob, qStart, qEnd, sphereCenter, bufferedR);
            % If non-collision
            % Delete nodes in between & search for curr start
            if ~collision
                qMilestonesSmoothed(startIdx+1:endIdx-1,:) = [];
                endIdx = startIdx;
                found = true; 
                break;
            end
        end
        
        % Move end one back, if non-collision path 
        % for curr end not found
        if ~found
            endIdx = endIdx - 1;
        end
    
        % Finish if reached the 2nd node
        if endIdx < 3 
            finished = true;
        end
    end
    
    if DEBUG_PLOT_PATH
        plotPath(rob, qMilestonesSmoothed);     
    end
    
    qMilestonesSmoothed;    
end

function plotPath(rob, qMilestonesSmoothed)
	path = [];
	[pathLen,~] = size(qMilestonesSmoothed);
	for i = 1:pathLen
        p = rob.fkine(qMilestonesSmoothed(i,:));
        p = p(1:3,4);
        path = [path p];
	end
	plot3(path(1,:),path(2,:),path(3,:),'*-');    
end
