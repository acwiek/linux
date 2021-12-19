#include <linux/printk.h>
#include <linux/kernel.h>

void __cyg_profile_func_enter(void *this_fn, void *call_site)
                              __attribute__((no_instrument_function));

void __cyg_profile_func_exit(void *this_fn, void *call_site)
                             __attribute__((no_instrument_function));


void __cyg_profile_func_enter(void *this_fn, void *call_site) {
//  printk("tpm_addr_enter: 0x%px 0x%px \n", this_fn, call_site);

  printk("func: %ps\n", this_fn);

//  printk("func:  %ps\n", this_fn);

//  printk("%s: called from %pS\n", __func__, (void *)_RET_IP_);

}

void __cyg_profile_func_exit(void *this_fn, void *call_site) {
//  printk("tpm_addr_exit: 0x%px 0x%px \n", this_fn, call_site);


}

EXPORT_SYMBOL(__cyg_profile_func_enter);
EXPORT_SYMBOL(__cyg_profile_func_exit);
