{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "virtualNetwork1Name": {
            "type": "string",
            "minLength": 1,
            "metadata": {
                "description": "Name of the first virtual network."
            }
        },
        "virtualNetwork2Name": {
            "type": "string",
            "minLength": 1,
            "metadata": {
                "description": "Name of the second virtual network."
            }
        }
    },
    "variables": {
        "virtualNetwork1Id": "[resourceId('Microsoft.Network/virtualNetworks', parameters('virtualNetwork1Name'))]",
        "virtualNetwork2Id": "[resourceId('Microsoft.Network/virtualNetworks', parameters('virtualNetwork2Name'))]"
    },
    "resources": [
        {
            "type": "Microsoft.Network/virtualNetworkPeerings",
            "name": "[concat(parameters('virtualNetwork1Name'), '/', parameters('virtualNetwork2Name'))]",
            "apiVersion": "2019-09-01",
            "location": "[resourceGroup().location]",
            "properties": {
                "allowVirtualNetworkAccess": true,
                "allowForwardedTraffic": true,
                "allowGatewayTransit": false,
                "useRemoteGateways": false,
                "remoteVirtualNetwork": {
                    "id": "[variables('virtualNetwork2Id')]"
                }
            },
            "dependsOn": [
                "[resourceId('Microsoft.Network/virtualNetworks', parameters('virtualNetwork1Name'))]",
                "[resourceId('Microsoft.Network/virtualNetworks', parameters('virtualNetwork2Name'))]"
            ]
        }
    ],
    "outputs": {}
}
