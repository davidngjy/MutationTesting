using FluentAssertions;
using Xunit;

namespace MutationTesting.Business.Test.UnitTests
{
	public class ComparisonTests
	{
		[Fact]
		public void LessThanTest()
		{
			// Arrange
			var comparison = new Comparison();

			// Act
			var result = comparison.LessThan(1, 1);

			// Assert
			result.Should().BeFalse();
		}

		[Fact]
		public void MoreThanTest()
		{
			// Arrange
			var comparison = new Comparison();

			// Act
			var result = comparison.MoreThan(1, 1);

			// Assert
			result.Should().BeFalse();
		}
	}
}