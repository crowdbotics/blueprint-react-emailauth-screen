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

echo ">> remove blueprint folder"
if [ -d "$BASE_PATH/src/features/$BLUEPRINT" ]; then rm -Rf $BASE_PATH/src/features/$BLUEPRINT; fi

echo ">> remove 1" 
sed -i "/${DATA_1}/d" $BASE_PATH/src/_nav.js

echo ">> remove 2"
sed -i "/${DATA_2}/d" $BASE_PATH/src/App.js

echo ">> remove 3"
sed -i "/${DATA_3}/d" $BASE_PATH/src/App.js

echo ">> remove 4"
sed -i "/${DATA_4}/d" $BASE_PATH/src/redux/mainReducer.js

echo ">> remove 5"
sed -i "/${DATA_5}/d" $BASE_PATH/src/redux/mainReducer.js

echo ">> remove 6"
sed -i "/${DATA_6}/d" $BASE_PATH/src/redux/mainSaga.js

echo ">> remove 7"
sed -i "/${DATA_7}/d" $BASE_PATH/src/redux/mainSaga.js

# echo ">> remove 8"
# sed -i "/${DATA_8}/d" $BASE_PATH/src/features/index.js

# echo ">> remove 9"
# sed -i "/${DATA_9}/d" $BASE_PATH/src/features/index.js

# echo ">> remove 10"
# sed -i "/${DATA_10}/d" $BASE_PATH/src/routes.js