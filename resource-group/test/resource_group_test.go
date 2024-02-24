package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/stretchr/testify/assert"
)

func TestTerraformResourceGroup(t *testing.T) {

	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")

	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")

	resourceGroupExists := azure.ResourceGroupExists(t, resourceGroupName, subscriptionId)

	assert.True(t, resourceGroupExists)
}