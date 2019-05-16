* IDEA是非常优秀的Java IDE，建议大家使用2016版本，至于破解方法，请自行百度。
* 我现在创建了新的项目newclass，大家需要配置，和eclipse不同的地方大致如下：     

> * idea和eclipse最大的区别，直观上是，idea的project对应eclipse里面的workspace，而idea的module对应eclipse的project。其他区别，在使用过程中，你会发现idea是多么智能！
> * 导入项目之后，要在Project Structure设置里面，Modules的Libraries里面加入Tomact依赖。
> * 配置Tomcat的话，需要在VM options 加上 -Dfile.encoding=UTF-8 ，不然tomcat的控制台会出现中文乱码，然后Application context 给/newclass/。    
> * 在新的项目里面，我们把配置文件放在了resources/conf目录下，这样编译后会直接进入classes的路径下，如果在其他配置文件或者测试程序中引用文件，可以通过classpath:conf/xxx，
如果你的路径是正确的，你可以ctrl并且鼠标放在这个字符串上，会看见这个目录的绝对路径（很智能是不）。

> * hibenate部分，和eclipse差别较大。总结一下：
    
>> * 做数据库表到实体的自动生成(mapping)不需要插件了，IDEA自带这个功能，大家配置好右边的Database和左边的Persistence就可以进行映射了。具体的内容，大家可以去百度什么的。
至于生成的实体的名称，前缀和后缀什么的，我趋向于不给，这样简单一些。当然，也可以给个默认的Entity作为后缀。
>> * 对于生成的实体类，Entity，由于数据库表设计的原因，会有一些报错，比如没有主键或者在做mysql类型到Java基本类型转换的时候，有些内容会通不过检查，对于这种情况，大家可以
忽略或者手动去修改转换规则或者修改代码，编译和执行其实是不受这些警告甚至报错的影响的。例子的话，你可以自己生成默认的，然后和dao包下的两个对比一下，看看怎么修改。
>> * Dao在com.newclass.dao下，所有的dao都要继承一个BaseDao，大家具体实现的时候，可以自己想一下怎么设计接口、抽象类什么的。

* 需要注意的是，mysql的配置文件被ignore了，所以需要自己加入本地的配置。比如: 
> 
jdbc.user=root   
jdbc.password=root    
jdbc.driverClass=com.mysql.jdbc.Driver    
jdbc.jdbcUrl=jdbc:mysql://localhost:3306/mysql?useUnicode=true&characterEncoding=UTF-8     
jdbc.initPoolSize=20    
jdbc.maxPoolSize=50

* Spring MVC测试过了，能访问 http://localhost:8080/newclass/index ，说明成功了。
* 测试相关代码都写在test下面，默认的话，包名加一个test，对应测试类的后面带Test。
* 其他问题可能需要后续再修改。


以上内容改自“校视通”项目，原文为陈洁和孙泽群两位学长所写，如有修改不慎的地方，大家尽可能提出，一起学习！

ljw