################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include Drivers/STM32F1xx_HAL_Driver/Src/subdir.mk
-include Drivers/CMSIS_DSP/Source/TransformFunctions/subdir.mk
-include Drivers/CMSIS_DSP/Source/SupportFunctions/subdir.mk
-include Drivers/CMSIS_DSP/Source/StatisticsFunctions/subdir.mk
-include Drivers/CMSIS_DSP/Source/MatrixFunctions/subdir.mk
-include Drivers/CMSIS_DSP/Source/FilteringFunctions/subdir.mk
-include Drivers/CMSIS_DSP/Source/FastMathFunctions/subdir.mk
-include Drivers/CMSIS_DSP/Source/ControllerFunctions/subdir.mk
-include Drivers/CMSIS_DSP/Source/ComplexMathFunctions/subdir.mk
-include Drivers/CMSIS_DSP/Source/CommonTables/subdir.mk
-include Drivers/CMSIS_DSP/Source/BasicMathFunctions/subdir.mk
-include Core/Startup/subdir.mk
-include Core/Src/subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

OPTIONAL_TOOL_DEPS := \
$(wildcard ../makefile.defs) \
$(wildcard ../makefile.init) \
$(wildcard ../makefile.targets) \


BUILD_ARTIFACT_NAME := bluePill_dual_PWM_IIR_bandpass
BUILD_ARTIFACT_EXTENSION := elf
BUILD_ARTIFACT_PREFIX :=
BUILD_ARTIFACT := $(BUILD_ARTIFACT_PREFIX)$(BUILD_ARTIFACT_NAME)$(if $(BUILD_ARTIFACT_EXTENSION),.$(BUILD_ARTIFACT_EXTENSION),)

# Add inputs and outputs from these tool invocations to the build variables 
EXECUTABLES += \
bluePill_dual_PWM_IIR_bandpass.elf \

MAP_FILES += \
bluePill_dual_PWM_IIR_bandpass.map \

SIZE_OUTPUT += \
default.size.stdout \

OBJDUMP_LIST += \
bluePill_dual_PWM_IIR_bandpass.list \


# All Target
all: main-build

# Main-build Target
main-build: bluePill_dual_PWM_IIR_bandpass.elf secondary-outputs

# Tool invocations
bluePill_dual_PWM_IIR_bandpass.elf bluePill_dual_PWM_IIR_bandpass.map: $(OBJS) $(USER_OBJS) C:\Users\leand\git\STM32_Experimental_Audio\PWM\workspace-stm32\bluePill_dual_PWM_IIR_bandpass\STM32F103C8TX_FLASH.ld makefile objects.list $(OPTIONAL_TOOL_DEPS)
	arm-none-eabi-gcc -o "bluePill_dual_PWM_IIR_bandpass.elf" @"objects.list" $(USER_OBJS) $(LIBS) -mcpu=cortex-m3 -T"C:\Users\leand\git\STM32_Experimental_Audio\PWM\workspace-stm32\bluePill_dual_PWM_IIR_bandpass\STM32F103C8TX_FLASH.ld" --specs=nosys.specs -Wl,-Map="bluePill_dual_PWM_IIR_bandpass.map" -Wl,--gc-sections -static --specs=nano.specs -mfloat-abi=soft -mthumb -Wl,--start-group -lc -lm -Wl,--end-group
	@echo 'Finished building target: $@'
	@echo ' '

default.size.stdout: $(EXECUTABLES) makefile objects.list $(OPTIONAL_TOOL_DEPS)
	arm-none-eabi-size  $(EXECUTABLES)
	@echo 'Finished building: $@'
	@echo ' '

bluePill_dual_PWM_IIR_bandpass.list: $(EXECUTABLES) makefile objects.list $(OPTIONAL_TOOL_DEPS)
	arm-none-eabi-objdump -h -S $(EXECUTABLES) > "bluePill_dual_PWM_IIR_bandpass.list"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) bluePill_dual_PWM_IIR_bandpass.elf bluePill_dual_PWM_IIR_bandpass.list bluePill_dual_PWM_IIR_bandpass.map default.size.stdout
	-@echo ' '

secondary-outputs: $(SIZE_OUTPUT) $(OBJDUMP_LIST)

fail-specified-linker-script-missing:
	@echo 'Error: Cannot find the specified linker script. Check the linker settings in the build configuration.'
	@exit 2

warn-no-linker-script-specified:
	@echo 'Warning: No linker script specified. Check the linker settings in the build configuration.'

.PHONY: all clean dependents main-build fail-specified-linker-script-missing warn-no-linker-script-specified

-include ../makefile.targets
