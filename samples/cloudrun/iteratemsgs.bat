#Start of for loop
for a in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
do
	
	# Print the value
	sleep 0.1
	echo "Iteration no $a"
	gcloud pubsub topics publish pubsub-topic-1 --message "pub-sun-topic-1 run 8 msg no $a"
        gcloud pubsub topics publish pubsub-topic-2 --message "pub-sun-topic-2 run 8 msg no $a"
done

