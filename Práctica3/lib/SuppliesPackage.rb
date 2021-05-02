#enconding: utf-8

# Representa los suministros para una estación espacial

module Deepspace
    class SuppliesPackage
        def initialize(ammopower, fuelunits, shieldpower)
            @ammoPower = ammopower
            @fuelUnits = fuelunits
            @shieldPower = shieldpower
        end

        def self.newCopy(package)   # Constructor de copia
            new(package.ammoPower, package.fuelUnits, package.shieldPower)
        end

        def ammoPower 
            @ammoPower
        end

        def fuelUnits
            @fuelUnits
        end

        def shieldPower
            @shieldPower
        end
    end
end

# Código de prueba
# prueba = Deepspace::SuppliesPackage.new(1,1,1)
# puts prueba.fuelUnits
# pruebacopy = Deepspace::SuppliesPackage.new(2,2,2)
# puts pruebacopy.fuelUnits
# prueba2 = Deepspace::SuppliesPackage.newCopy(pruebacopy)
# puts prueba2.fuelUnits
