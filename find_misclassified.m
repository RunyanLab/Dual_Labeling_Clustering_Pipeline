function[unsuccessful]=find_misclassified(cluster_outcome,errors,titlestr,figyesno)

% function to look at silhouette scores of data for clustering combinations
% that only had x amount of misclassified cells  


overall_score=nan(length(cluster_outcome),1);
success=nan(length(cluster_outcome),1);
clength=nan(length(cluster_outcome),1);
focus=zeros(length(cluster_outcome),1);

for i=1:length(cluster_outcome)
    overall_score(i)=cluster_outcome(i).overall;
    success(i)=cluster_outcome(i).success; 
    clength(i)=cluster_outcome(i).length;
    
%     if cluster_outcome(i).identoutcome(2)== 0 && cluster_outcome(i).identoutcome(27)==0 && cluster_outcome(i).identoutcome(29)==0 && sum(cluster_outcome(i).identoutcome==0)<4
%         focus(i)=1;
%     end

    if sum(cluster_outcome(i).identoutcome==0)>errors(1) && sum(cluster_outcome(i).identoutcome==0)<=errors(2)
        focus(i)=1;
    end



end

% 
% [sorted_overall,overall_idx]=sort(overall_score,'descend');
% 
% sorted_success=success(overall_idx);
% 
% unsuccessful= find(sorted_success==0);
% sorted_cluster=cluster_outcome(overall_idx);
unsuccessful=find(focus==1);
% %go into unsuccessful and then index into 
correct_scores=cluster_outcome(unsuccessful(1)).scores;%at this stage, all scores
incorrect_scores=correct_scores(cluster_outcome(unsuccessful(1)).identoutcome==0);
correct_scores=correct_scores(cluster_outcome(unsuccessful(1)).identoutcome==1);


for i=2:length(unsuccessful)
    curscores=cluster_outcome(unsuccessful(i)).scores;
    
    incorrect_scores=[incorrect_scores;curscores(cluster_outcome(unsuccessful(i)).identoutcome==0)];
    correct_scores=[correct_scores;curscores(cluster_outcome(unsuccessful(i)).identoutcome==1)];

end

all_scores=[correct_scores;incorrect_scores];

stdev=std(all_scores);



if strcmp(figyesno,'yes')
    figure('color','w')
    set(gca,'fontsize', 14)
    set(gca,'FontName','helvetica')
    histg=histogram(correct_scores(1:length(incorrect_scores)*4),50,'FaceColor','w');
    hold on 
    histgi=histogram(incorrect_scores,50,'FaceColor','k');
    
%     text(min(histg.BinEdges),max(histg.Values)*.9,['mean correct scores: ',num2str(round(mean(correct_scores),2))],'Color','g')
%     text(min(histg.BinEdges),max(histg.Values)*.8,['mean incorrect scores: ',num2str(round(mean(incorrect_scores),2))],'Color','r')
%     text(min(histg.BinEdges),max(histg.Values)*.7,['stdev all scores: ',num2str(round(stdev,2))],'Color','k')
    %text(min(histg.BinEdges),max(histg.Values)*.6,['stdev all scores: ',num2str(round(stdev,2))],'Color','k')
    
    
    %xline(mean(correct_scores),'Color','g')
    %xline(mean(incorrect_scores),'color','r')
    xlabel('Silhouette Score')
    ylabel('Frequency')
    yticks([0 35000])
    yticklabels({'0','35000'})
    %title(titlestr)
    xline(.7,'LineWidth',3,'color','r','HandleVisibility','off')%mean(incorrect_scores)+std(incorrect_scores
    legend({'Correctly Classified SS','Incorrectly Classified SS'},'Location','northwest')
    title('Exclusion Criterion Determined From Simulated Noisy Data')

end
