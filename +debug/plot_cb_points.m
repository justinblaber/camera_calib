function plot_cb_points(points,cb_img,a)
    % This overlays points over cb_img and plots it.
        
    if ~exist('a','var')
        f = figure(); 
        a = axes(f);
    end
    cla(a);
    
    % Show image
    imshow(cb_img.get_gs(),[],'parent',a);
    hold(a,'on');
    
    % Plot points
    plot(points(:,1),points(:,2),'go','MarkerSize',6,'LineWidth',1,'parent',a);
    
    % Remove hold
    drawnow
    hold(a,'off');
end