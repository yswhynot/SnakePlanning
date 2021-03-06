function extend = getSnakePolicyExtendFunc(maxSteps)
        
    function pointAdded = extendHelper(tree, startInd, policy, ...
                                       numSteps)
        originalTree = tree.points;
        
        x = originalTree(startInd, :);
        
        parentInd = startInd;

        iter = 0;
        
        % prevCost = policy.cost(x);
        % x = x + policy.getAction(x)*stepSize;
        % newCost = policy.cost(x);
        
        % makingProgress = newCost < prevCost && ...
        %     ~policy.obs.collides(x);
        
        % EProgress = (prevCost - newCost)*.2; %minimium expected progress
        [u, progress] = policy.getAction(x);
        x = x+u;
        while( progress && ...
               ~policy.reachedGoal(x) && ...
               iter < numSteps)
               % nearestPoint(originalTree, x) == startInd && ...

            iter = iter + 1;
            if(mod(iter, 10) == 0)
                tree.add(x, parentInd);
                parentInd = length(tree.parents);
                policy.sphereModel.plot(x);
            end
            % if(mod(iter,10) == 0)
            %     [angles, contacts] = policy.separateState(x);
            %     policy.sphereModel.plot(angles, contacts);
            % end

            
            % prevCost = newCost;
            [u, progress] = policy.getAction(x);
            x = x+u;
            
            
            
            % policy.sphereModel.plot(x);
            % pause(.1)
            % if( sqrt(sumsqr(x - goal)) < .7)
            %     makingProgress
            %     nearestPoint(originalTree, x) == startInd
            %     disp('close');
                
            % end


        end
        
        if(policy.reachedGoal(x))
            tree.add(x, parentInd);
        end
        
        % if(nearestPoint(originalTree, x) ~= startInd)
        %     disp('entered explored region')
        % end
        if(~progress)
            disp('Stopped making progress')
        end
        % pause(1)
       
        
        % if( sqrt(sumsqr(x - goal)) < .7)
        %     numSteps
        %     makingProgress
        %     prevCost
        %     newCost
        %     nearestPoint(originalTree, x) == startInd
        %     disp('close');
            
        % end

        pointAdded = iter > 0;
        if(pointAdded)
            % [angles, contacts] = policy.separateState(x);
            % policy.sphereModel.plot(angles, contacts);
            policy.sphereModel.plot(x);
        end

    end
    
    function policyExtend(tree, firstGoal, finalGoal, policy)
        n = length(firstGoal);
        % startInd = nearestPoint(tree.points(:,1:n), firstGoal);
        startInd = nearestPoint(tree.points, [firstGoal]);
        policy.setGoalAngles(firstGoal);
        if(~extendHelper(tree, startInd, ...
                         policy, maxSteps))
            return;
        end
        disp('attempting towards goal')
        policy.setGoal(finalGoal);
        extendHelper(tree, size(tree.points,1), ...
                     policy, maxSteps);
    end
    
    extend = @policyExtend;
end
