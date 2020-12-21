# AKLab 7
## Program code 
```c
#include <linux/init.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/printk.h>
#include <linux/types.h>
#include <linux/slab.h>
#include <linux/ktime.h>

struct head_list {
  struct head_list *next;
  ktime_t time;
};

MODULE_AUTHOR("Borovyk Rostyslav IV-82");
MODULE_DESCRIPTION("Lab7, debug techniques");
MODULE_LICENSE("Dual BSD/GPL");

static struct head_list *head;

static uint times = 1;
module_param(times,uint,S_IRUGO);
MODULE_PARM_DESC(times, "Output Repeating");

static int __init init(void)
{
  uint i = 0;
  struct head_list *var_1, *var_2, *m, *var;

  head = kmalloc(sizeof(struct head_list *), GFP_KERNEL);

  var_1 = head;


  if(times == 0) {
    pr_warn("times = 0");
  }else if(times >=5 && times <= 10) {
    pr_warn("times is between 5 and 10");
  }
  BUG_ON(times>10);

  for(i = 0; i < times; i++){
    m = kmalloc(sizeof(struct head_list), GFP_KERNEL);
    if (i == 7){
        m = NULL;
    }
    if (ZERO_OR_NULL_PTR(m)){
        pr_err("No memory available");
        while (head != NULL && times != 0) {
            var = head;
            head = var->next;
            kfree(var);
        }
        BUG_ON(!m);
        return -ENOMEM;
    }
    var_1->time = ktime_get();
    pr_info("hello!");
    var_2 = var_1;
    var_1 = m;
  }
  if (times != 0) {
    kfree(var_2->next);
    var_2->next = NULL;
  }
  pr_info("Repeat times: %d\n", times);
  return 0;
}

static void __exit exit(void)
{
  struct head_list *var;

  while (head != NULL && times != 0) {
    var = head;
    pr_info("Time: %lld", var->time);
    head = var->next;
    kfree(var);
  }
  pr_info("");
}


module_init(init);
module_exit(exit);


```
