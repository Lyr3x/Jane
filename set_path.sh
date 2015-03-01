 #!/bin/bash
 
 echo `pwd`
 ( [ `dirname $0` == '.' ] && echo ) || echo "/`dirname $0`"

