cron "feedback_summary_report" do
    hour "21"
    minute "30"
    weekday "*"
    command "curl 'http://localhost/resource/getSummaryByDateInterval?days=1&apikey=1fd9aada-812a-40f1-8fb7-4601e2150251'"
end

cron "feedback_test_single" do
    hour "21"
    minute "31"
    weekday "*"
    command "cd /srv/www/feedback_debug/current; npm test"
end

cron "feedback_test_api" do
    hour "*"
    minute "31"
    weekday "*"
    command "cd /srv/www/feedback_debug/current; npm test"
end
