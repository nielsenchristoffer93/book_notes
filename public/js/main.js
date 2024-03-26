const searchInputElement = document.getElementById("search-input");
const sortSelectElement = document.getElementById("sort-by__select");

console.log(searchInputElement);
console.log(sortSelectElement);

// Load the last selected value from localStorage
const lastSelectedValue = localStorage.getItem('selectedSortByOption');
if (lastSelectedValue) {
    sortSelectElement.value = lastSelectedValue;
}

// Listen for changes and save the selected value
sortSelectElement.addEventListener('change', function () {
  const selectedValue = sortSelectElement.value;
  localStorage.setItem('selectedSortByOption', selectedValue);
  this.form.submit();
});