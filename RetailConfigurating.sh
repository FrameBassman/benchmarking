export WORK_DIR=/root/jenkins_home/workspace/setretail10
export SERV_IP=172.xx.xx.xx
export SHOP_NUM=xxxx

echo [INFO] start cd to setrobot-core
cd $WORK_DIR/SetRetail10_Utils/testStand/SetRobot/setrobot-core
echo [INFO] end cd to setrobot-core

echo [INFO] start gradle copyGoodsXML
gradle copyGoodsXML
echo [INFO] end gradle copyGoodsXML

echo [INFO] start cd to setrobothub
cd $WORK_DIR/SetRetail10_Utils/testStand/SetRobot/setrobot-core/build/data/setrobothub
echo [INFO] end cd to setrobothub

echo [INFO] start cp catalog-goods-robot.xml
cp catalog-goods-robot.xml $WORK_DIR/SetRetail10_Utils/testStand/SetTester/src/test/resources/import
echo [INFO] end cp catalog-goods-robot.xml

echo [INFO] start cd to SetTester
cd $WORK_DIR/SetRetail10_Utils/testStand/SetTester
echo [INFO] end cd to SetTester

echo [TIME] Current time:
date +"%T.%6N"
echo

echo [INFO] start gradle test
gradle clean test --continue -Ptest_suite=suite_sco_server_config.xml -Dtest_retail_host=$SERV_IP -Dtest_shop_number=$SHOP_NUM -Dtest_os_type=LINUX -Dstand_config=retail
echo [INFO] end gradle test

echo [TIME] Finish time:
date +"%T.%6N"
echo

git checkout $WORK_DIR/SetRetail10_Utils/testStand/SetTester/src/test/resources/import/catalog-goods-robot.xml

