#!/bin/bash

# Initialize basic vars and helpers
source blueprint-lib/init.sh

##
# Add dependencies here
##

# source blueprint-lib/docker.sh

##
# ADD BLUEPRINT CODE BELOW HERE
#
# BASE_PATH is the full path to the project root
# APP_NAME is the name of the Django app that will be modified
##

BLUEPRINT="$3"
NAME="$4"

if [ -z "$BLUEPRINT" ]
then
    BLUEPRINT="EmailAuth"
fi

if [ -z "$NAME" ] 
then
    NAME="EmailAuth"
fi

EXT_POINT_1="@InsertNav"
EXT_POINT_2="@InertModuleDeclaration"
EXT_POINT_3="{/*InsertModuleRouting*/}"
EXT_POINT_8="@InsertModuleImport"
EXT_POINT_9="@InsertModule"
EXT_POINT_10="@InsertModuleRoutes"
EXT_POINT_4="@BlueprintReduxImportInsertion"
EXT_POINT_5="@BlueprintReduxCombineInsertion"
EXT_POINT_6="@BlueprintReduxSagaImportInsertion"
EXT_POINT_7="@BlueprintReduxSagaMainInsertion"
DATA_1="{
    name: '${NAME}',
    url: '/email-auth',
    icon: 'icon-envelope',
    children: [
      {
        name: 'Login',
        url: '/login',
        icon: 'icon-star',
      },
      {
        name: 'Register',
        url: '/register',
        icon: 'icon-star',
      }
    ],
},"
DATA_2="const Login = React.lazy(() => import('./features\/${BLUEPRINT}\/Login'));
const Register = React.lazy(() => import('./features\/${BLUEPRINT}\/Register'));"

DATA_3="<Route exact path='/login' name='Login Page' render={props => <Login {...props}/>} />
<Route exact path='/register' name='Register Page' render={props => <Register {...props}/>} />"

# DATA_8=""

# DATA_9=""

# DATA_10=""

DATA_4="import ${BLUEPRINT}Reducer from '..\/features\/${BLUEPRINT}\/redux\/reducers';"
DATA_5="${BLUEPRINT}: ${BLUEPRINT}Reducer,"
DATA_6="import ${BLUEPRINT}Saga from '..\/features\/${BLUEPRINT}\/redux\/sagas';"
DATA_7="${BLUEPRINT}Saga,"

echo "create blueprint folder"
mkdir -p $BASE_PATH/src/features/$BLUEPRINT

echo "copy"
cp -r ./EmailAuth/. $BASE_PATH/src/features/$BLUEPRINT

echo ">> insert 1" 
sed -i "s/${EXT_POINT_1}/&\n${DATA_1}/g" $BASE_PATH/src/_nav.js

echo ">> insert 2" 
sed -i "s/${EXT_POINT_2}/&\n${DATA_2}/g" $BASE_PATH/src/App.js

echo ">> insert 3"
sed -i "s/${EXT_POINT_3}/&\n${DATA_3}/g" $BASE_PATH/src/App.js

echo ">> insert 4" 
sed -i "s/${EXT_POINT_4}/&\n${DATA_4}/g" $BASE_PATH/src/redux/mainReducer.js

echo ">> insert 5"
sed -i "s/${EXT_POINT_5}/&\n${DATA_5}/g" $BASE_PATH/src/redux/mainReducer.js

echo ">> insert 6" 
sed -i "s/${EXT_POINT_6}/&\n${DATA_6}/g" $BASE_PATH/src/redux/mainSaga.js

echo ">> insert 7"
sed -i "s/${EXT_POINT_7}/&\n${DATA_7}/g" $BASE_PATH/src/redux/mainSaga.js

# echo ">> insert 8"  
# sed -i "s/${EXT_POINT_8}/&\n${DATA_3}/g" $BASE_PATH/src/features/index.js

# echo ">> insert 9" 
# sed -i "s/${EXT_POINT_9}/&\n${DATA_3}/g" $BASE_PATH/src/features/index.js

# echo ">> insert 10" 
# sed -i "s/${EXT_POINT_10}/&\n${DATA_3}/g" $BASE_PATH/src/routes.js
