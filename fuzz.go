package fuzzy

import "github.com/hashicorp/hcl"

// Fuzz does go-fuzz work
func Fuzz(data []byte) int {
	if len(data) == 0 {
		return -1
	}

	if _, err := ParseSafely(data); err != nil {
		return 0
	}

	return 1
}

// ParseSafely does what it says on the tin
func ParseSafely(buf []byte) (out interface{}, err error) {
	return out, hcl.Unmarshal(buf, &out)
}
