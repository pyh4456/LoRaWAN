################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Users/USER/Desktop/STM32CubeExpansion_LRWAN_V2.1.0/Drivers/BSP/CMWX1ZZABZ_0xx/cmwx1zzabz_0xx.c 

OBJS += \
./Drivers/BSP/CMWX1ZZABZ_0xx/cmwx1zzabz_0xx.o 

C_DEPS += \
./Drivers/BSP/CMWX1ZZABZ_0xx/cmwx1zzabz_0xx.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/BSP/CMWX1ZZABZ_0xx/cmwx1zzabz_0xx.o: C:/Users/USER/Desktop/STM32CubeExpansion_LRWAN_V2.1.0/Drivers/BSP/CMWX1ZZABZ_0xx/cmwx1zzabz_0xx.c Drivers/BSP/CMWX1ZZABZ_0xx/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m0plus -std=gnu11 -g3 -DSTM32L072xx -DUSE_B_L072Z_LRWAN1 -DCMWX1ZZABZ0XX -c -I../../../LoRaWAN/App -I../../../LoRaWAN/Target -I../../../Core/Inc -I../../../../../../../../Utilities/misc -I../../../../../../../../Utilities/timer -I../../../../../../../../Utilities/trace/adv_trace -I../../../../../../../../Utilities/lpm/tiny_lpm -I../../../../../../../../Utilities/sequencer -I../../../../../../../../Drivers/BSP/B-L072Z-LRWAN1 -I../../../../../../../../Drivers/BSP/CMWX1ZZABZ_0xx -I../../../../../../../../Drivers/STM32L0xx_HAL_Driver/Inc -I../../../../../../../../Drivers/CMSIS/Device/ST/STM32L0xx/Include -I../../../../../../../../Drivers/CMSIS/Include -I../../../../../../../../Middlewares/Third_Party/SubGHz_Phy -I../../../../../../../../Middlewares/Third_Party/SubGHz_Phy/sx1276 -I../../../../../../../../Middlewares/Third_Party/LoRaWAN/Crypto -I../../../../../../../../Middlewares/Third_Party/LoRaWAN/Mac -I../../../../../../../../Middlewares/Third_Party/LoRaWAN/Mac/Region -I../../../../../../../../Middlewares/Third_Party/LoRaWAN/Utilities -I../../../../../../../../Middlewares/Third_Party/LoRaWAN/LmHandler -I../../../../../../../../Middlewares/Third_Party/LoRaWAN/LmHandler/packages -I../../../../../../../../Drivers/BSP/IKS01A2 -I../../../../../../../../Drivers/BSP/Components/Common -I../../../../../../../../Drivers/BSP/Components/hts221 -I../../../../../../../../Drivers/BSP/Components/lps22hb -I../../../../../../../../Drivers/BSP/Components/lsm6dsl -I../../../../../../../../Drivers/BSP/Components/lsm303agr -Os -ffunction-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@"

clean: clean-Drivers-2f-BSP-2f-CMWX1ZZABZ_0xx

clean-Drivers-2f-BSP-2f-CMWX1ZZABZ_0xx:
	-$(RM) ./Drivers/BSP/CMWX1ZZABZ_0xx/cmwx1zzabz_0xx.d ./Drivers/BSP/CMWX1ZZABZ_0xx/cmwx1zzabz_0xx.o ./Drivers/BSP/CMWX1ZZABZ_0xx/cmwx1zzabz_0xx.su

.PHONY: clean-Drivers-2f-BSP-2f-CMWX1ZZABZ_0xx

