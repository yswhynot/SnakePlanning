% function [interpAngles] = INTERPOLATETRAJECTORY (angles, interpFactor)
% Linear Interpolation between the discrete points on trajectory. 
% interpFactor = equals to the number of interpolation segments

function interpAngles = interpolateTrajectory(angles, interpFactor)
    n = size(angles, 2);
    interpAngles = angles(:,1);
    for i=2:n
        prev = angles(:,i-1);
        cur = angles(:,i);
        for j=1:interpFactor
            newAngle = prev + (cur-prev)*j/interpFactor;
            interpAngles = [interpAngles, newAngle];
        end
    end
end
