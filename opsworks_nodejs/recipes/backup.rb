cron "feedback_data_backup" do
    day "*"
    hour "21"
    minute "30"
    command "pg_dump --host=localhost --port=5432 --username=postgres --no-password --format=c --file=/home/data/${maponics_feedback}-$(date '+%a-%b%d-%Y-%H.%M.%S.%Z').backup maponics_feedback"
end
