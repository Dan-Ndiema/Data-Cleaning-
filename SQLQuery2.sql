select *
from Portfolioproject1.dbo.NashvilleHousing

select SaleDateconverted, Convert(Date, SaleDate)
from Portfolioproject1.dbo.NashvilleHousing

update Portfolioproject1.dbo.NashvilleHousing
set SaleDate = Convert(Date, SaleDate)

                                                
select PropertyAddress
from Portfolioproject1.dbo.NashvilleHousing
--where PropertyAddress is null
order by ParcelID


select x.ParcelID,x.PropertyAddress,y.ParcelID,y.PropertyAddress, isnull(x.PropertyAddress, y.PropertyAddress)
from Portfolioproject1.dbo.NashvilleHousing x
join Portfolioproject1.dbo.NashvilleHousing y
on x.ParcelID = y.ParcelID
AND x.[UniqueID ] <> y.[UniqueID ]
where x.PropertyAddress is null

update x
set PropertyAddress = isnull(x.PropertyAddress, y.PropertyAddress)
from Portfolioproject1.dbo.NashvilleHousing x
join Portfolioproject1.dbo.NashvilleHousing y
on x.ParcelID = y.ParcelID
AND x.[UniqueID ] <> y.[UniqueID ]
where x.PropertyAddress is null

select PropertyAddress
from Portfolioproject1.dbo.NashvilleHousing

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

from Portfolioproject1.dbo.NashvilleHousing

Alter Table Portfolioproject1.dbo.NashvilleHousing
add Propertysplitaddress NVARCHAR(255);

update Portfolioproject1.dbo.NashvilleHousing
set Propertysplitaddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

Alter Table Portfolioproject1.dbo.NashvilleHousing
add Propertysplitcity NVARCHAR(255);

update Portfolioproject1.dbo.NashvilleHousing
set Propertysplitcity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

Select *
from Portfolioproject1.dbo.NashvilleHousing


Select OwnerAddress
from Portfolioproject1.dbo.NashvilleHousing

select
PARSENAME(REPLACE(OwnerAddress, ',', '.') ,3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') ,2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') ,1)
from Portfolioproject1.dbo.NashvilleHousing


Alter Table Portfolioproject1.dbo.NashvilleHousing
add OwnerSplitAddress NVARCHAR(255);

update Portfolioproject1.dbo.NashvilleHousing
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') ,3)

Alter Table Portfolioproject1.dbo.NashvilleHousing
add OwnerSplitCity NVARCHAR(255);

update Portfolioproject1.dbo.NashvilleHousing
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') ,2)

Alter Table Portfolioproject1.dbo.NashvilleHousing
add OwnerSplitState NVARCHAR(255);

update Portfolioproject1.dbo.NashvilleHousing
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') ,1)

Select *
from Portfolioproject1.dbo.NashvilleHousing

 


SELECT SoldAsVacant
, CASE when SoldAsVacant = 'Y' THEN 'YES'
       WHEN SoldAsVacant = 'N' THEN 'NO'
	   ELSE SoldAsVacant
	   END
from Portfolioproject1.dbo.NashvilleHousing


UPDATE Portfolioproject1.dbo.NashvilleHousing  
SET SoldAsVacant = CASE when SoldAsVacant = 'Y' THEN 'YES' 
       WHEN SoldAsVacant = 'N' THEN 'NO'
	   ELSE SoldAsVacant
	   END


--Removing Duplicates
WITH RowNumCTE AS(
Select *,
      ROW_NUMBER () OVER (
	  PARTITION BY ParcelID,
	               PropertyAddress,
				   SalePrice,
				   SaleDate,
				   LegalReference
				   Order BY
				      UniqueID
					  )row_num

from Portfolioproject1.dbo.NashvilleHousing
--order by ParcelID
)
SELECT * 
From RowNumCTE
where row_num > 1
--order by PropertyAddress





Select *
from Portfolioproject1.dbo.NashvilleHousing

ALTER TABLE Portfolioproject1.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, SaleDate, PropertyAddress