open ~/workspaces/luminis/chefke/update-events/update-events.cfg

cd ~/workspaces/luminis/chefke
./gradlew update-events:run  2>&1 | tee -a ~/Desktop/chefke-update.log