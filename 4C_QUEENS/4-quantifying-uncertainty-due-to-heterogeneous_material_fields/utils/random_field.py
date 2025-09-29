from queens.parameters.random_fields._random_field import RandomField
import numpy as np


class CustomRandomField(RandomField):
    def __init__(self, coords, latent_distribution, expansion):
        super().__init__(coords)
        self.latent_distribution = latent_distribution
        self.expansion = expansion
        self.coordinates = coords["coords"]
        self.dimension = self.latent_distribution.dimension

    def draw(self, num_samples):
        """Draw samples of the latent space.

        Args:
            num_samples (int): Batch size of samples to draw
        """
        return self.latent_distribution.draw(num_samples)

    def expanded_representation(self, samples):
        """Expand the random field realization.

        Args:
            samples (np.array): Latent space variables to be expanded into a random field
        """

        if samples.ndim == 1:
            return self.expansion(samples, self.coordinates)

        expansions = []

        for sample in samples:
            expansions.append(self.expansion(sample, self.coordinates))

        return np.array(expansions)

    def logpdf(self, samples):
        """Get joint logpdf of latent space.

        Args:
            samples (np.array): Sample to evaluate logpdf
        """
        return self.latent_distribution.logpdf(samples)

    def grad_logpdf(self, samples):
        """Get gradient of joint logpdf of latent space.

        Args:
            samples (np.array): Sample to evaluate gradient of logpdf
        """
        raise NotImplementedError()

    def latent_gradient(self, upstream_gradient):
        """Graident of the field with respect to the latent variables."""
        raise NotImplementedError()
